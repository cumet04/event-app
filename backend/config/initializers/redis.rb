Backend::Application.config.tap do |config|
  redis_url = "redis://#{ENV.fetch('RAILS_REDIS_HOST')}:#{ENV.fetch('RAILS_REDIS_PORT')}"

  config.cache_store = :redis_cache_store, { url: "#{redis_url}/0/cache" }

  config.middleware.insert_before Rack::Head, ActionDispatch::Cookies
  config.middleware.insert_before Rack::Head, ActionDispatch::Session::RedisStore, {
    servers: ["#{redis_url}/1/session"],
    expire_after: 90.minutes,
    secure: config.session_redis_secure
  }
end
