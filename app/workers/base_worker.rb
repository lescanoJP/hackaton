class BaseWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def log(message)
    Rails.logger.info(message)
    puts(message)
  end

end
