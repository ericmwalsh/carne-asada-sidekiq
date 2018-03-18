# ::BaseExtractWorker
class BaseExtractWorker < ::BaseWorker

  sidekiq_options :queue => 'extract', :retry => false

  def perform
    # hit APIs (or caches)
    prices_worker.perform_async
    volumes_worker.perform_in(10.seconds)
  end

  private

  def exchange_name
    raise ::NotImplementedError, 'define this in your worker'
  end

  def prices_worker
    "::#{exchange_name.capitalize}::PricesWorker".constantize
  end

  def volumes_worker
    "::#{exchange_name.capitalize}::VolumesWorker".constantize
  end

end
