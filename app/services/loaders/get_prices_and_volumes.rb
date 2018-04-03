# ::Loaders::GetPricesAndVolumes
module Loaders
  class GetPricesAndVolumes
    extend ::Helpers

    class << self
      # start time timestamp, end time timestamp, minute interval
      # ::Loaders::GetPricesAndVolumes.perform(1521516300, 1521516600, 1)
      def perform(st, et, intvl = 1) # int, int, int
        unless validate_inputs(st, et, intvl)
          raise ::Exceptions::BaseError, 'invalid input params'
        end
        prices = ensure_prices(st, et, intvl)
        volumes = ensure_volumes(st, et, intvl)

        # merge_prices_and_volumes(prices, volumes)

        prices
        volumes
      end

      private

      def merge_prices_and_volumes(prices, volumes) # hash, hash
        #
      end

      # ::Loaders::GetPricesAndVolumes.send(:ensure_prices, 1521516300, 1521516600, 1)
      def ensure_prices(st, et, intvl)  # int, int, int
        exchange_map = exchange_map(timestamp_map(st, et, intvl))
        sql_prices = load_prices(st, et, intvl)
        grouped_prices = timestamp_map(st, et, intvl, [])
        # {"exchange"=>"binance", "symbol"=>"ADA/BTC", "base_asset"=>"ADA", "quote_asset"=>"BTC", "times"=>1521516360.0, "price"=>2.226e-05}
        sql_prices.each do |price_hash|
          exchange_map[price_hash['exchange']][price_hash['times'].to_i] = true
          grouped_prices[price_hash['times'].to_i].push(price_hash)
        end
        missing_price_map = determine_missing_prices(exchange_map)
        fill_missing_prices!(grouped_prices, missing_price_map)

        grouped_prices
      end

      def determine_missing_prices(exchange_map) # hash
        missing_price_map = {}
        exchange_map.values.first.keys.each do |timestamp|
          missing_price_map[timestamp] = []
        end

        exchange_map.each do |exchange, timestamp_map|
          timestamp_map.each do |timestamp, values_present|
            unless values_present
              missing_price_map[timestamp] << exchange
            end
          end
        end

        missing_price_map
      end

      def fill_missing_prices!(grouped_prices, missing_price_map) # hash, hash
        missing_prices = {}

        # used to keep track of the index during this each loop
        count = 0
        missing_price_map.each do |timestamp, exchange_array|
          # first row missing prices is different than any other row
          # because it must be fetched from the db; all other rows can
          # be copied from the preceding timestamp
          if exchange_array.present?
            if count == 0
              load_missing_prices(timestamp, exchange_array).each do |pricing_hash|
                grouped_prices[timestamp] << pricing_hash
              end
            else
              previous_timestamp = missing_price_map.keys[count-1]

              grouped_prices[previous_timestamp].each do |price_hash|
                if exchange_array.include? price_hash['exchange']
                  grouped_prices[timestamp] << price_hash.merge('times' => timestamp)
                end
              end
            end
          end
          count += 1
        end

        grouped_prices
      end

      def load_missing_prices(timestamp, exchanges) # int, array of strings
        execute_query(
          <<~HEREDOC
            #{
              exchanges.map do |exchange|
                "
                  SELECT '#{exchange}' as exchange, p.symbol, tp.base_asset, tp.quote_asset, #{timestamp} as times, avg(p.price) as avgp
                  FROM public.#{exchange}_prices p
                  JOIN public.trading_pairs tp
                  ON p.symbol = tp.symbol
                  WHERE p.timestamp = (
                    SELECT MAX(timestamp)
                    FROM public.#{exchange}_prices
                    WHERE timestamp < #{timestamp}
                  )
                  GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times
                "
              end.join(' UNION ALL ')
            }
          HEREDOC
        )
      end

      # ::Loaders::GetPricesAndVolumes.send(:load_prices, 1521516300, 1521516600, 1)
      def load_prices(st, et, intvl)  # int, int, int
        execute_query(
          <<~HEREDOC
            SELECT *
            FROM calculate_usd_prices(
              #{st}, #{et}, #{intvl}
            )
          HEREDOC
        )
      end

      # ::Loaders::GetPricesAndVolumes.send(:ensure_volumes, 1521516300, 1521516600, 1)
      def ensure_volumes(st, et, intvl)  # int, int, int
        exchange_map = exchange_map(timestamp_map(st, et, intvl))
        sql_volumes = load_volumes(st, et, intvl)
        grouped_volumes = timestamp_map(st, et, intvl, [])
        # {"exchange"=>"binance", "symbol"=>"ADA/BTC", "base_asset"=>"ADA", "quote_asset"=>"BTC", "times"=>1521516360.0, "base_volume"=>213222586.0, "quote_volume"=>4406.43820258}
        sql_volumes.each do |volume_hash|
          exchange_map[volume_hash['exchange']][volume_hash['times'].to_i] = true
          grouped_volumes[volume_hash['times'].to_i].push(volume_hash)
        end
        missing_volume_map = determine_missing_volumes(exchange_map)
        fill_missing_volumes!(grouped_volumes, missing_volume_map)

        grouped_volumes
      end

      def determine_missing_volumes(exchange_map) # hash
        missing_volume_map = {}
        exchange_map.values.first.keys.each do |timestamp|
          missing_volume_map[timestamp] = []
        end

        exchange_map.each do |exchange, timestamp_map|
          timestamp_map.each do |timestamp, values_present|
            unless values_present
              missing_volume_map[timestamp] << exchange
            end
          end
        end

        missing_volume_map
      end

      def fill_missing_volumes!(grouped_volumes, missing_volume_map) # hash, hash
        missing_volumes = {}

        # used to keep track of the index during this each loop
        count = 0
        missing_volume_map.each do |timestamp, exchange_array|
          # first row missing volumes is different than any other row
          # because it must be fetched from the db; all other rows can
          # be copied from the preceding timestamp
          if exchange_array.present?
            if count == 0
              load_missing_volumes(timestamp, exchange_array).each do |volume_hash|
                grouped_volumes[timestamp] << volume_hash
              end
            else
              previous_timestamp = missing_volume_map.keys[count-1]

              grouped_volumes[previous_timestamp].each do |volume_hash|
                if exchange_array.include? volume_hash['exchange']
                  grouped_volumes[timestamp] << volume_hash.merge('times' => timestamp)
                end
              end
            end
          end
          count += 1
        end

        grouped_volumes
      end

      def load_missing_volumes(timestamp, exchanges) # int, array of strings
        execute_query(
          <<~HEREDOC
            #{
              exchanges.map do |exchange|
                "
                  SELECT '#{exchange}' as exchange, v.symbol, tp.base_asset, tp.quote_asset, #{timestamp} as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
                  FROM public.#{exchange}_volumes v
                  JOIN public.trading_pairs tp
                  ON v.symbol = tp.symbol
                  WHERE v.timestamp = (
                    SELECT MAX(timestamp)
                    FROM public.#{exchange}_volumes
                    WHERE timestamp < #{timestamp}
                  )
                  GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times
                "
              end.join(' UNION ALL ')
            }
          HEREDOC
        )
      end

      # ::Loaders::GetPricesAndVolumes.send(:load_volumes, 1521516300, 1521516600, 1)
      def load_volumes(st, et, intvl)  # int, int, int
        execute_query(
          <<~HEREDOC
            SELECT *
            FROM calculate_usd_volumes(
              #{st}, #{et}, #{intvl}
            )
          HEREDOC
        )
      end

      def exchange_map(timestamp_map) # hash
        exchange_map = {}
        EXCHANGES.each do |exchange|
          exchange_map[exchange] = timestamp_map
        end
        exchange_map
      end

      def timestamp_map(st, et, intvl, val = false) # int, int, int, any
        timestamp_map = {}
        intvl_in_seconds = intvl.to_i * 60

        count = st.to_i + intvl_in_seconds
        while count <= et.to_i
          timestamp_map[count] = val.dup
          count += intvl_in_seconds
        end

        timestamp_map
      end

      def validate_inputs(st, et, intvl) # int, int, int
        timestamp_delta = et.to_i - st.to_i
        intvl_in_seconds = intvl.to_i * 60
        if timestamp_delta <= 0 || intvl_in_seconds <= 0
          false
        elsif timestamp_delta % intvl_in_seconds != 0
          false
        else
          true
        end
      end

    end
  end
end
