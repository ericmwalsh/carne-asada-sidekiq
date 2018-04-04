# ::Loaders::VolumeWeightedAverage
module Loaders
  class VolumeWeightedAverage
    extend ::Helpers

    class << self

      # [..., {"exchange"=>"poloniex", "symbol"=>"ZRX/ETH", "base_asset"=>"ZRX", "quote_asset"=>"ETH", "times"=>1521724860, "price"=>0.00116609, "base_volume"=>135942.97719985, "quote_volume"=>144.2767299}, ...]
      # {"AUD"=>1.270106, "CAD"=>1.2843, "CNY"=>6.326903, "EUR"=>0.810204, "GBP"=>0.71912, "JPY"=>106.279999, "KRW"=>1063.369995, "NZD"=>1.369397, "RUB"=>56.860106}
      # ["USDT", "NZDT", "BTC", "XBT", "ETH", "BCH", "LTC", "NEO", "XMR", "QTUM", "BNB", "DOGE", "KCS", "XAUR", "SNET"]
      def perform(pvs, fiat_currencies, base_currencies) # arr of hashes, hash, arr
        converted_markets = {}
        converted_currencies = {}

        base_currencies = base_currencies - ALIASES.keys # remove any unnecessary alias duplicates
        fiats = fiat_currencies.keys

        convert_hash = {}
        needs_conversion = []

        # split into groups
        pvs.each do |market_hash|
          # filter out markets with bad price
          next if market_hash['price'] == 0
          # deal with aliases
          encode_alias!(market_hash)

          if fiats.include? market_hash['quote_asset']
            # filter out fiat / fiat
            # i.e. {"exchange"=>"bitstamp","symbol"=>"EUR/USD","base_asset"=>"EUR","quote_asset"=>"USD","times"=>1520826960.0,"price"=>1.2294}
            unless fiats.include? market_hash['base_asset']
              converted_market_hash = market_hash.merge(
                'converted' => market_hash['price'].to_f * (1 / fiat_currencies[market_hash['quote_asset']].to_f)
              )

              if convert_hash[market_hash['base_asset']].present?
                convert_hash[market_hash['base_asset']].push(converted_market_hash)
              else
                convert_hash[market_hash['base_asset']] = [converted_market_hash]
              end
            end
          elsif base_currencies.include? market_hash['base_asset']
            needs_conversion.push(market_hash)
          else
            if convert_hash[market_hash['base_asset']].present?
              convert_hash[market_hash['base_asset']].push(market_hash)
            else
              convert_hash[market_hash['base_asset']] = [market_hash]
            end
          end
        end

        # calculate base currencies using fiats and recursion flipping
        base_currencies.each do |bc|
          bc_value = calculate_volume_weighted_average_value!(bc, convert_hash[bc])
          converted_currencies[bc] = bc_value

          needs_conversion.delete_if do |market_hash|
            if market_hash['base_asset'] == bc || market_hash['quote_asset'] == bc
              # need to flip market pair
              if market_hash['base_asset'] == bc
                flip_market_pair!(market_hash)
              end

              # now quote_asset must == bc
              converted_market_hash = market_hash.merge(
                'converted' => market_hash['price'].to_f * bc_value
              )

              if convert_hash[market_hash['base_asset']].present?
                convert_hash[market_hash['base_asset']].push(converted_market_hash)
              else
                convert_hash[market_hash['base_asset']] = [converted_market_hash]
              end

              true
            else
              false
            end
          end
        end

        # calculate markets and remaining currencies
        convert_hash.each do |currency, market_hashes|
          # convert market and push into converted_markets
          market_hashes.each do |market_hash|
            # add converted property if not already there
            convert_market!(
              market_hash,
              converted_currencies,
              fiat_currencies
            )

            market_symbol = market_hash['final_symbol']
            converted_market_hash = {
              'aliased' => market_hash['aliased'].present?,
              'outlier' => market_hash['outlier'].present?,
              'value' => market_hash['converted'],
              'base_volume' => market_hash['base_volume'],
              'quote_volume' => market_hash['quote_volume']
            }

            if converted_markets[market_hash['exchange']].present?
              converted_markets[market_hash['exchange']][market_symbol] = converted_market_hash
            else
              converted_markets[market_hash['exchange']] = {
                market_symbol => converted_market_hash
              }
            end
          end

          # filter out base_currencies
          unless converted_currencies[currency].present?
            converted_currencies[currency] = calculate_volume_weighted_average_value!(
              currency,
              convert_hash[currency]
            )
          end
        end


        {
          'markets' => converted_markets,
          'currencies' => converted_currencies
        }
      end

      private

      def convert_market!(market_hash, converted_currencies, fiat_currencies) # hash, hash, hash
        # has this been flipped or aliased
        if market_hash['og_symbol'].present?
          # if flipped
          if [ ALIASES[market_hash['og_quote_asset']], market_hash['og_quote_asset'] ].include? market_hash['base_asset']
            # unflip
            flip_market_pair!(market_hash)
            if market_hash['converted'].present?
              market_hash['converted'] = market_hash['price'] * converted_currencies[market_hash['quote_asset']]
            end
          end
          # alias
          if market_hash['base_asset'] == ALIASES[market_hash['og_base_asset']] || market_hash['quote_asset'] == ALIASES[market_hash['og_quote_asset']]
            market_hash['aliased'] = true
          end
          # filter out already calculated
          unless market_hash['converted'].present?
            market_hash['converted'] = market_hash['price'] * converted_currencies[market_hash['quote_asset']]
          end

          market_hash['final_symbol'] = market_hash['og_symbol']
        # original market
        else
          market_hash['final_symbol'] = market_hash['symbol']
          # calculated already? - do nothing
          # else need to calculate
          unless market_hash['converted'].present?
            market_hash['converted'] = market_hash['price'] * converted_currencies[market_hash['quote_asset']]
          end
        end
      end

      def calculate_average_value!(bc, market_hashes, converted_markets = nil) # string, hash, hash
        if market_hashes.present?
          market_hashes.sort! {|mh_0, mh_1| mh_0['converted'] <=> mh_1['converted'] }
          values = market_hashes.map {|market_hash| market_hash['converted']}
          values_mean = values.mean
          if values.size <= 3
            values_mean
          else
            values_std_dev = values.standard_deviation

            values.select.with_index do |value, i|
              if value > (values_mean - 3 * values_std_dev) && value < (values_mean + 3 * values_std_dev)
                true
              else
                # mark as outlier
                # being used for base_assets
                if converted_markets.nil?
                  market_hashes[i].merge!('outlier' => true)
                # being used for remaining assets
                else
                  converted_markets[market_hashes[i]['exchange']][market_hashes[i]['final_symbol']]['outlier'] = true
                end
                false
              end
            end.mean
          end
        else
          if bc == 'NZDT'
            0.73
          elsif bc == 'USDT'
            1.0
          else
            nil
          end
        end
      end

      def calculate_volume_weighted_average_value!(bc, market_hashes) # string, hash
        if market_hashes.present?
          market_hashes.sort! {|mh_0, mh_1| mh_0['converted'] <=> mh_1['converted'] }
          total_volume = 0
          total_price_volume = market_hashes.inject(0) do |sum, market_hash|
            total_volume += market_hash['base_volume']
            sum + market_hash['converted'] * market_hash['base_volume']
          end
          total_price_volume / total_volume
        else
          if bc == 'NZDT'
            0.73
          elsif bc == 'USDT'
            1.0
          else
            nil
          end
        end
      end

      def flip_market_pair!(market_hash) # hash
        # if aliased before leave original
        unless market_hash['og_symbol'].present?
          market_hash['og_symbol'] = market_hash['symbol']
          market_hash['og_base_asset'] = market_hash['base_asset']
          market_hash['og_quote_asset'] = market_hash['quote_asset']
          market_hash['og_price'] = market_hash['price']
          market_hash['og_base_volume'] = market_hash['base_volume']
          market_hash['og_quote_volume'] = market_hash['quote_volume']
        end

        # parallel assignment swap trick
        market_hash['base_asset'], market_hash['quote_asset'] = market_hash['quote_asset'], market_hash['base_asset']
        market_hash['base_volume'], market_hash['quote_volume'] = market_hash['quote_volume'], market_hash['base_volume']

        market_hash['price'] = (1.0 / market_hash['price'].to_f)
        market_hash['symbol'] = "#{market_hash['base_asset']}/#{market_hash['quote_asset']}"
      end

      def encode_alias!(market_hash) # hash
        if ALIASES.keys.include?(market_hash['base_asset']) || ALIASES.keys.include?(market_hash['quote_asset'])
          market_hash['og_base_asset'] = market_hash['base_asset']
          market_hash['og_quote_asset'] = market_hash['quote_asset']
          market_hash['og_price'] = market_hash['price']
          market_hash['og_symbol'] = market_hash['symbol']
          market_hash['og_base_volume'] = market_hash['base_volume']
          market_hash['og_quote_volume'] = market_hash['quote_volume']

          if ALIASES.keys.include?(market_hash['base_asset']) && ALIASES.keys.include?(market_hash['quote_asset'])
            market_hash['base_asset'] = ALIASES[market_hash['base_asset']]
            market_hash['quote_asset'] = ALIASES[market_hash['quote_asset']]
          elsif ALIASES.keys.include? market_hash['base_asset']
            market_hash['base_asset'] = ALIASES[market_hash['base_asset']]
          elsif ALIASES.keys.include? market_hash['quote_asset']
            market_hash['quote_asset'] = ALIASES[market_hash['quote_asset']]
          end
          market_hash['symbol'] = "#{market_hash['base_asset']}/#{market_hash['quote_asset']}"
        end
      end

    end
  end
end
