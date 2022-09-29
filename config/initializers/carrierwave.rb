CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.enable_processing = Rails.env.development?
    config.asset_host = Rails.application.credentials.dig(Rails.env.to_sym, :app_domain)
  else
    config.storage    = :aws
    config.aws_bucket = Rails.application.credentials.dig(Rails.env.to_sym, :aws_s3, :bucket_name) || ''
    config.aws_acl    = 'public-read'

   config.aws_credentials = {
      access_key_id:     Rails.application.credentials.dig(Rails.env.to_sym, :aws_s3, :access_key_id) || '',
      secret_access_key: Rails.application.credentials.dig(Rails.env.to_sym, :aws_s3, :secret_access_key) || '',
      region:            Rails.application.credentials.dig(Rails.env.to_sym, :aws_s3, :region) || ''
    }
  end
end
