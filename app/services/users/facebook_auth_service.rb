class ::Users::FacebookAuthService < BusinessProcess::Base
  needs :oauth2_params

  steps :init_facebook_validator,
        :validate_token,
        :find_facebook_user,
        :find_user_by_email,
        :create_user

  def call
    process_steps
    @user
  end

  private

  def init_facebook_validator
    # Credentials configured in initializers/koala.rb
    @koala = Koala::Facebook::API.new(oauth2_params[:oauth2_token])
  end

  def validate_token
    @response = @koala.get_object('me', fields: [:name, :email, :picture])&.deep_symbolize_keys
  rescue
    fail([I18n.t('services.facebook_auth_service.errors.invalid_token')])
  end

  def find_facebook_user
    @user = User.find_by(provider: 'facebook', uid: @response[:id])
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

  def define_user_email
    # When user does't has email in your fb account
    @response[:email] || "#{@response[:id]}@facebook.com"
  end

  def user_params
    {
      uid: @response[:id],
      provider: 'facebook',
      email: define_user_email,
      name: @response[:name],
      remote_avatar_url: @response.dig(:picture, :data, :url),
      password: Devise.friendly_token[0, 20]
    }
  end

end
