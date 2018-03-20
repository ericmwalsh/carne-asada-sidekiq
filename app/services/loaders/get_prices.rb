# ::Loaders::GetPrices
module Loaders
  class GetPrices
    extend ::Helpers

    class << self
      # start time timestamp, end time timestamp, minute interval
      # ::Loaders::GetPrices.get_prices(1521516300, 1521516600, 1)
      def get_prices(st, et, intvl = 1) # int, int, int
        stored_prices = load_prices(st, et, intvl)
        # byebug
        stored_prices
      end

      private

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

    end
  end
end
