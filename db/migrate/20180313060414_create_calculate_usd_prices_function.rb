class CreateCalculateUsdPricesFunction < ActiveRecord::Migration[5.1]
  def up
    execute <<~HEREDOC
      CREATE OR REPLACE FUNCTION calculate_usd_prices(ts float, te float, gap integer)
      RETURNS TABLE(
        exchange        text,
        symbol          varchar,
        base_asset      varchar,
        quote_asset     varchar,
        times           timestamptz,
        price           float
      ) AS
      $func$
        DECLARE int_seconds integer := gap * 60;
              BEGIN
              RETURN QUERY

              SELECT p.exchange, p.symbol, p.base_asset, p.quote_asset, p.times, p.avgp
              FROM
              (SELECT 'binance' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.binance_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'bitstamp' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.bitstamp_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'bittrex' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.bittrex_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'cexio' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.cexio_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'cryptopia' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.cryptopia_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gateio' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.gateio_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gdax' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.gdax_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gemini' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.gemini_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'kraken' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.kraken_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'kucoin' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.kucoin_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'mercatox' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.mercatox_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'poloniex' as exchange, p.symbol, tp.base_asset, tp.quote_asset, to_timestamp(ceil(p.timestamp/int_seconds)*int_seconds) as times, avg(p.price) as avgp
              FROM public.poloniex_prices p
              JOIN public.trading_pairs tp
              ON p.symbol = tp.symbol
              WHERE p.timestamp > ts
              AND p.timestamp <= te
              GROUP BY p.symbol, tp.base_asset, tp.quote_asset, times
              ) p;

              END;
      $func$ LANGUAGE plpgsql;
    HEREDOC
  end

  def down
    execute <<~HEREDOC
      DROP FUNCTION IF EXISTS calculate_usd_prices;
    HEREDOC
  end
end
