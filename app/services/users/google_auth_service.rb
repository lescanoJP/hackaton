class Users::GoogleAuthService < BusinessProcess::Base
  CLIENTS_ID = {
    ios: Rails.application.credentials.dig(Rails.env.to_sym, :google_auth, :ios_client_id),
    android: Rails.application.credentials.dig(Rails.env.to_sym, :google_auth, :android_client_id),
    web: Rails.application.credentials.dig(Rails.env.to_sym, :google_auth, :web_client_id)
  }.freeze

  needs :oauth2_params

  steps :init_google_validator,
        :define_client_id,
        :validate_token,
        :find_google_user,
        :find_user_by_email,
        :create_user

  def call
    process_steps
    @user
  end

  private

  def init_google_validator
    @validator = GoogleIDToken::Validator.new
  end

  def define_client_id
    @client_id_by_platform = CLIENTS_ID[oauth2_params[:platform]&.to_sym]
  end

  def validate_token
    @response = @validator.check(oauth2_params[:oauth2_token], @client_id_by_platform)&.deep_symbolize_keys
  rescue
    fail([I18n.t('services.google_auth_service.errors.invalid_token')])
  end

  def find_google_user
    @user = User.find_by(provider: 'google', uid: @response[:sub])
  end

  def find_user_by_email
    return if @user.present?

    @user = User.find_by(email: @response[:email])
  end

  def create_user
    return if @user.present?

    @user = User.new(user_params)

    fail(@user.errors.full_messages) unless @user.save
  end

  def user_params
    {
      uid: @response[:sub],
      provider: 'google',
      email: @response[:email],
      name: @response[:given_name],
      remote_avatar_url: @response[:picture],
      password: Devise.friendly_token[0, 20]
    }
  end

end
