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

        merge_prices_and_volumes(prices, volumes)
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
        grouped_prices = fill_missing_prices(grouped_prices, missing_price_map)

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

      def fill_missing_prices(grouped_prices, missing_price_map) # hash, hash
        filled_prices = {}
        missing_prices = {}

        count = 0
        missing_price_map.each do |timestamp, exchange_array|
          #
        end

        filled_prices
        grouped_prices # temp
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

      def ensure_volumes(st, et, intvl)  # int, int, int
        exchange_map = exchange_map(timestamp_map(st, et, intvl))
        sql_volumes = load_volumes(st, et, intvl)
      end

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
          timestamp_map[count] = val
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
