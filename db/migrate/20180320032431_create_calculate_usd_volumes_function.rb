class CreateCalculateUsdVolumesFunction < ActiveRecord::Migration[5.1]
  def up
    execute <<~HEREDOC
      CREATE OR REPLACE FUNCTION calculate_usd_volumes(ts float, te float, gap integer)
      RETURNS TABLE(
        exchange        text,
        symbol          varchar,
        base_asset      varchar,
        quote_asset     varchar,
        times           float,
        base_volume     float,
        quote_volume    float
      ) AS
      $func$
        DECLARE int_seconds integer := gap * 60;
              BEGIN
              RETURN QUERY

              SELECT v.exchange, v.symbol, v.base_asset, v.quote_asset, v.times, v.mbv, v.mqv
              FROM
              (SELECT 'binance' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.binance_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'bitstamp' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.bitstamp_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'bittrex' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.bittrex_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'cexio' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.cexio_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'cryptopia' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.cryptopia_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gateio' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.gateio_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gdax' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.gdax_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'gemini' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.gemini_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'kraken' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.kraken_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'kucoin' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.kucoin_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'mercatox' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.mercatox_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times

              UNION ALL

              SELECT 'poloniex' as exchange, v.symbol, tp.base_asset, tp.quote_asset, ceil(v.timestamp/int_seconds)*int_seconds as times, max(v.base_volume) as mbv, max(v.quote_volume) as mqv
              FROM public.poloniex_volumes v
              JOIN public.trading_pairs tp
              ON v.symbol = tp.symbol
              WHERE v.timestamp > ts
              AND v.timestamp <= te
              GROUP BY v.symbol, tp.base_asset, tp.quote_asset, times
              ) v;

              END;
      $func$ LANGUAGE plpgsql;
    HEREDOC
  end

  def down
    execute <<~HEREDOC
      DROP FUNCTION IF EXISTS calculate_usd_volumes;
    HEREDOC
  end
end
