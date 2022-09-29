# Sidekiq.configure_client do |config|
#   config.redis = { url: "redis://localhost:6379", namespace: "e_o_progrides#{Rails.env}_redis" }

#   Sidekiq::Status.configure_client_middleware(config, expiration: 1.week)
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: "redis://localhost:6379", namespace: "e_o_progrides#{Rails.env}_redis" }

#   Sidekiq::Status.configure_server_middleware(config, expiration: 1.week)
#   Sidekiq::Status.configure_client_middleware(config, expiration: 1.week)
# end

# if File.exists?(schedule_file) && Sidekiq.server?
#   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
# end

# Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
#   ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
#                                               ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:admin_username])) &
#   ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
#                                               ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:admin_password]))
# end

