# Get the base Redis URL without the database part
redis_base = ENV.fetch("REDIS_URL", "redis://redis:6379").split("/").first(3).join("/")

# Set database index 2 for Sidekiq
sidekiq_redis_url = "#{redis_base}/2"

Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_redis_url }
end
