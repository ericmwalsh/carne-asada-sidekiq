# ::Loaders::GetPricesAndVolumes
module Loaders
  class GetPricesAndVolumes
    extend ::Helpers

    class << self
      # start time timestamp, end time timestamp, minute interval
      # ::Loaders::GetPricesAndVolumes.perform(1521516300, 1521516600, 1)
      def perform(st, et, intvl = 1) # int, int, int
        prices = ensure_prices(load_prices(st, et, intvl))
        volumes = ensure_volumes(load_volumes(st, et, intvl))

        merge_prices_and_volumes(prices, volumes)
      end

      private

      def merge_prices_and_volumes(prices, volumes) # hash, hash
        #
      end

      def ensure_prices(sql_prices) # PG::Result (enumerable)
        sql_prices
      end

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

      def ensure_volumes(sql_volumes) # PG::Result (enumerable)
        sql_volumes
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

    end
  end
end
