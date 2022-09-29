class Users::AppleAuthService < BusinessProcess::Base
  # CLIENT_ID is used to compare with the attribute aud from JWT sent by apple
  # For more informations:
  # https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_rest_api/authenticating_users_with_sign_in_with_apple
  CLIENT_ID = Rails.application.credentials.dig(Rails.env.to_sym, :apple_auth, :client_id)

  needs :oauth2_params

  steps :init_apple_validator,
        :validate_token,
        :find_apple_user,
        :find_user_by_email,
        :create_user

  def call
    process_steps
    @user
  end

  private

  def init_apple_validator
    @validator = AppleIdToken::Validator
  end

  def validate_token
    @response = @validator.validate(token: oauth2_params[:oauth2_token], aud: CLIENT_ID)&.deep_symbolize_keys
  rescue
    fail([I18n.t('services.apple_auth_service.errors.invalid_token')])
  end

  def find_apple_user
    @user = User.find_by(provider: 'apple', uid: @response[:sub])
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

  def define_user_name
    # Create user name complete because apple dont give only attribute :name
    "#{oauth2_params[:user_info][:given_name]} #{oauth2_params[:user_info][:family_name]}"
  end

  def user_params
    {
      uid: @response[:sub],
      provider: 'apple',
      email: @response[:email],
      name: define_user_name,
      password: Devise.friendly_token[0, 20]
    }
  end

end
