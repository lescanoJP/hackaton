class Api::V1::SessionsController < Api::ApiController
  before_action :oauth2_params, only: [:facebook_auth, :google_auth]

  def create
    response_handler(Users::SessionService.call(session_params: session_params))
  end

  def facebook_auth
    response_handler(Users::FacebookAuthService.call(oauth2_params: oauth2_params))
  end

  def google_auth
    response_handler(Users::GoogleAuthService.call(oauth2_params: oauth2_params))
  end

  def apple_auth
    response_handler(Users::AppleAuthService.call(oauth2_params: oauth2_params))
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def oauth2_params
    params.permit(:oauth2_token, :platform, user_info: {})
  end

  def response_handler(response)
    if response.success?
      sign_in response.result, store: false
      token = response.result.refresh_token
      respond_with response.result, location: '', scope: token
    else
      render_unprocessable_entity(response.error)
    end
  end

end
