# ::Loaders::Setup
module Loaders
  class Setup
    extend ::Helpers

    class << self

      # ::Loaders::Setup.perform(1521724800, 1521725100, 1)
      def perform(st, et, intvl = 1) # int, int, int
        prices_volumes = ::Loaders::GetPricesAndVolumes.perform(st, et, intvl)
        fiat_currencies = get_fiat_conversions(st, et)
        base_currencies = get_base_asset_currencies

        count = 0
        timestamps = prices_volumes[0].keys

        timestamps.each do |timestamp|
          next if count > 0
          fiats = fiat_currencies[beginning_of_day(timestamp)]
          bases = sort_by_volume(base_currencies - fiats.keys - ['USD'])

          pvs = combine_prices_volumes(prices_volumes[0][timestamp], prices_volumes[1][timestamp])

          puts ::Loaders::VolumeWeightedAverage.perform(
            pvs,
            fiats,
            bases
          ).to_json
          count += 1
        end
        count
      end

      private

      def combine_prices_volumes(prices, volumes) # arr of hashes, arr of hashes
        if prices.size != volumes.size
          raise ::Exceptions::BaseError, "price and volume asset mismatch - size check: prices #{prices.size}, volumes: #{volumes.size}"
        end

        volume_map = {}
        volumes.each do |volume_hash|
          volume_map["#{volume_hash['exchange']}-#{volume_hash['symbol']}"] = {
            'mbv' => volume_hash['mbv'],
            'mqv' => volume_hash['mqv']
          }
        end

        prices.map do |price_hash|
          volume_attrs = volume_map["#{price_hash['exchange']}-#{price_hash['symbol']}"]
          if volume_attrs.present?
            price_hash.merge(volume_attrs)
          else
            raise ::Exceptions::BaseError, "price and volume asset mismatch - volume asset missing: #{price_hash.to_json}"
          end
        end
      end

      def sort_by_volume(currencies, cbv = CURRENCIES_BY_VOLUME) # array of strings
        currencies.sort_by {|curr| cbv.index(curr) || ::Float::INFINITY}
      end

      def get_fiat_conversions(st, et)
        fiat_conversions = {}
        timestamps = [
          beginning_of_day(st),
          beginning_of_day(et)
        ].uniq

        execute_query(
          <<~HEREDOC
            SELECT *
            FROM public.usd_conversions
            WHERE timestamp IN (#{timestamps.join(', ')});
          HEREDOC
        ).each do |usd_conversion|
          conversion_map = {}
          usd_conversion.each do |currency, value|
            next if currency == 'timestamp' # skip timestamp column
            conversion_map[currency.upcase] = value
          end

          conversion_map['USD'] = 1
          fiat_conversions[usd_conversion['timestamp'].to_i] = conversion_map
        end

        fiat_conversions
      end

      def get_base_asset_currencies
        execute_query(
          <<~HEREDOC
            SELECT DISTINCT quote_asset
            FROM public.trading_pairs;
          HEREDOC
        ).map {|c| c['quote_asset']}
      end

    end
  end
end
