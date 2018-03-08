# ::BaseIntervalWorker
class BaseIntervalWorker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => false

  def perform
    # hit APIs (or caches)
    symbols_worker.perform_in(5.seconds)
    trading_pairs_worker.perform_in(10.seconds)
    snapshots_worker.perform_in(15.seconds)

    # doesn't hit APIs
    prices_s3_worker.perform_in(15.seconds)
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def symbols_worker
    "::#{exchange_name.capitalize}::SymbolsWorker".constantize
  end

  def trading_pairs_worker
    "::#{exchange_name.capitalize}::TradingPairsWorker".constantize
  end

  def prices_s3_worker
    "::#{exchange_name.capitalize}::PricesS3Worker".constantize
  end

  def snapshots_worker
    "::#{exchange_name.capitalize}::SnapshotsWorker".constantize
  end

end
