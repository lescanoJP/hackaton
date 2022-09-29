# Koala for authenticate user with facebook
#
Koala.configure do |config|
  config.app_id = Rails.application.credentials.dig(Rails.env.to_sym, :facebook_auth, :app_id)
  config.app_secret = Rails.application.credentials.dig(Rails.env.to_sym, :facebook_auth, :app_secret)
end
