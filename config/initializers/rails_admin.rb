RailsAdmin.config do |config|
  config.main_app_name = ['AppTemplate', 'Admin']

  if Rails.env.staging? || Rails.env.production?
    config.authorize_with do
      authenticate_or_request_with_http_basic('AppTemplate') do |username, password|
        username == Rails.application.credentials[Rails.env.to_sym].dig(:rails_admin, :username) &&
        password == Rails.application.credentials[Rails.env.to_sym].dig(:rails_admin, :password)
      end
    end
  end

  config.actions do
    dashboard
    index
    new
    bulk_delete
    show
    edit
    delete
  end

end
