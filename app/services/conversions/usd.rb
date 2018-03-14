# ::Conversions::Usd
module Conversions
  class Usd
    extend ::Helpers

    API_KEY = ENV['APILAYER_API_KEY']
    BASE_URL = 'http://apilayer.net/api' # ENV['APILAYER_URI']
    CURRENCIES = [
      'AUD',
      'CAD',
      'CNY',
      'EUR',
      'GBP',
      'JPY',
      'KRW',
      'NZD',
      'RUB'
    ]


    class << self

      def store_latest(api_key = API_KEY, currencies = CURRENCIES) # string
        rates = get_latest(api_key)
        rate_date = Time.at((rates['timestamp'].to_i / 86400).floor * 86400).utc
        if rate_date != Time.now.utc.beginning_of_day
          raise ::Exceptions::ApiServerError.new(
            rates.merge('message' => 'Response date is not equal to input date'),
            200
          )
        end

        conversion_values = []
        currencies.each do |currency|
          value = rates['quotes']["USD#{currency}"]
          value.present? ? conversion_values << value : 'null'
        end

        columns = currencies + ['timestamp']
        values = conversion_values + [rate_date.to_i]
        update_clause = columns[0...-1].map.with_index do |col, i|
          "#{col} = #{values[i]}"
        end.join(",\n")

        execute_query(
          <<~HEREDOC
            INSERT INTO usd_conversions (#{columns.join(', ')})
            VALUES (#{values.join(', ')})
            ON CONFLICT (timestamp) DO UPDATE SET
            #{update_clause};
          HEREDOC
        )
      end

      def store_historical(date, currencies = CURRENCIES, api_key = API_KEY) # string, array of strings, string
        historical_rates = get_historical(date, currencies, api_key)
        rate_date = Time.at((historical_rates['timestamp'].to_i / 86400).floor * 86400).utc
        if rate_date.strftime('%Y-%m-%d') != date
          raise ::Exceptions::ApiServerError.new(
            historical_rates.merge('message' => 'Response date is not equal to input date'),
            200
          )
        end

        conversion_values = []
        currencies.each do |currency|
          value = historical_rates['quotes']["USD#{currency}"]
          value.present? ? conversion_values << value : 'null'
        end

        columns = currencies + ['timestamp']
        values = conversion_values + [rate_date.to_i]
        update_clause = columns[0...-1].map.with_index do |col, i|
          "#{col} = #{values[i]}"
        end.join(",\n")

        execute_query(
          <<~HEREDOC
            INSERT INTO usd_conversions (#{columns.join(', ')})
            VALUES (#{values.join(', ')})
            ON CONFLICT (timestamp) DO UPDATE SET
            #{update_clause};
          HEREDOC
        )
      end

      private

      def get_historical(date, currencies = CURRENCIES, api_key = API_KEY) # string, array of strings, string
        request(
          :get,
          "historical?access_key=#{api_key}&date=#{date}&currencies=#{currencies.join(',')}"
        )
      end

      def get_latest(api_key = API_KEY) # string
        request(
          :get,
          "live?access_key=#{api_key}&format=1"
        )
      end

      def request(method, url, options = {})
        response = client.send(method) do |req|
          req.url url
          req.params.merge! options
        end
        intercept_errors(response.status, response.body)
        response.body
      end

      def intercept_errors(status, body) # integer, hash
        case status
        when 200
          unless body['success']
            raise ::Exceptions::ApiServerError.new(body, status)
          end
        when 429
          raise ::Exceptions::ApiRateLimitError.new(body, status)
        when 101..106, 201,202, 301, 302, 400..404, 501..505
          # user side
          raise ::Exceptions::ApiInputError.new(body, status)
        when 500
          raise ::Exceptions::ApiServerError.new(body, status)
        end
      end

      def client
        ::Faraday.new(url: "#{BASE_URL}") do |conn|
          conn.request :json
          conn.response :json, content_type: /\bjson$/
          conn.adapter ::Faraday.default_adapter
        end
      end

    end
  end
end
