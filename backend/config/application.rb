require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true

    config.cache_classes = true
    config.eager_load = true
    config.consider_all_requests_local = false
    config.public_file_server.enabled = false

    config.log_level = :info
    config.log_tags = [ :request_id ]
    config.logger = ActiveSupport::Logger.new(STDOUT)
    config.log_formatter = ::Logger::Formatter.new

    config.active_support.deprecation = :notify
    config.active_support.disallowed_deprecation = :log
    config.active_support.disallowed_deprecation_warnings = []
    config.active_record.dump_schema_after_migration = false
  end
end
