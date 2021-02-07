require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_record.dump_schema_after_migration = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.session_redis_secure = false
end
