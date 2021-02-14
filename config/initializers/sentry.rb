Sentry.init do |config|
  config.dsn = 'https://e2f17efa6e6048bfbb88f38ad4d25ccb@o523231.ingest.sentry.io/5636667'
  config.breadcrumbs_logger = [:active_support_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
