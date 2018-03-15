# ::Loaders::Prices
module Loaders
  class Prices
    extend ::Helpers

    CURRENCIES_BY_VOLUME = [
      'BTC',
      'ETH',
      'XRP',
      'BCH',
      'LTC',
      'ADA',
      'NEO',
      'XLM',
      'EOS',
      'XEM',
      'XMR',
      'DASH',
      'IOTA',
      'USDT',
      'TRX',
      'VEN',
      'ETC',
      'NANO',
      'LSK',
      'QTUM',
      'OMG',
      'BTG',
      'ICX',
      'BNB',
      'ZEC',
      'DOGE',
      'KCS',
      'XAUR',
      'NZDT',
      'SNET'
    ]

    class << self
      # ::Loaders::Prices.load_prices(1520826900, 1520827200)
      # starting_time, ending_time, minute_interval
      def load_prices(st, et, intvl = 1) # int, int, int
        prices = get_prices(st, et, intvl).group_by {|c| c['times']}
        fiat_currencies = get_fiat_conversions(st, et)
        base_currencies = get_base_asset_currencies

        count = 0
        prices.each do |timestamp, grouped_prices|
          next if count > 0
          fiats = fiat_currencies[beginning_of_day(timestamp)]
          bases = sort_by_volume(base_currencies - fiats.keys - ['USD'])

          puts ::Loaders::DeterminePrices.run(
            grouped_prices,
            fiats,
            bases
          ).to_json
          count += 1
        end
        count
      end

      private

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

      def get_prices(st, et, intvl) # int, int, int
        execute_query(
          <<~HEREDOC
            SELECT *
            FROM calculate_usd_prices(
              #{st}, #{et}, #{intvl}
            )
          HEREDOC
        )
      end

    end
  end
end
