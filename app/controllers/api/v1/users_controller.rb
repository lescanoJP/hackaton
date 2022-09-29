class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_user_from_token!, except: [:create, :recover_password, :reset_password]

  def create
    user = User.new(user_params)
    if user.save
      sign_in user, store: false
      respond_with user, location: '', scope: user.refresh_token
    else
      render_unprocessable_entity(user.errors.full_messages)
    end
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      render json: current_user, serializer: UserSerializer, scope: current_user.refresh_token
    else
      render_unprocessable_entity(current_user.errors.full_messages)
    end
  end

  def show
    headers = current_user.refresh_token
    respond_with current_user, location: '', scope: headers
  end

  def recover_password
    user = User.find_for_database_authentication(email: recover_password_params[:email])
    return not_found_error unless user.present?

    service = ::Users::RecoverPassword.call(user: user)
    response_handler(service)
  end

  def reset_password
    user = User.find_by(email: params[:email])

    return render_not_found_error unless user.present?

    user.send_reset_password_instructions
    render_success
  end

  private

  def user_params
    params.permit(:name, :email, :document, :password, :password_confirmation)
  end

  def recover_password_params
    params.permit(:email)
  end

  def response_handler(service)
    if service.success?
      render_success
    else
      render_unprocessable_entity(service.error)
    end
  end

end
