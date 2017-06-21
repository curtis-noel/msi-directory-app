Rails.application.configure do
  config.log_level = :info

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = false

  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = false
  config.assets.raise_runtime_errors = false

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_controller.allow_forgery_protection = false

  #config.serve_static_assets  = true
  #config.static_cache_control = 'public, max-age=3600'

  #config.assets.js_compressor = :uglifier
  #config.assets.compile = false
  #config.assets.digest = true
  #config.assets.version = '1.0'
  #config.force_ssl = false

  #config.i18n.fallbacks = true
  #config.active_support.deprecation = :notify
  #config.log_formatter = ::Logger::Formatter.new
  #config.active_record.dump_schema_after_migration = false
end
