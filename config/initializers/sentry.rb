# Docs: https://docs.sentry.io/platforms/ruby/guides/rails/?_ga=2.239344771.1451891542.1621627569-2105314301.1621627569
Sentry.init do |config|
  return unless %w[production staging].include?(Rails.env)

  config.dsn = Rails.application.credentials.dig(Rails.env.to_sym, :sentry_access_token) || ''
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 0.5
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end
end
