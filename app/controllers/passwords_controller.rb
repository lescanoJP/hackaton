class PasswordsController < Devise::PasswordsController
  def edit
  end

  def update
    self.resource = resource_class.reset_password_by_token(update_params)

    flash_message(resource.errors.messages.empty?)

    redirect_to action: 'edit', reset_password_token: params[:reset_password_token]
  end

  def update_params
    params.permit(:token, :reset_password_token, :password, :password_confirmation)
  end

  def flash_message(condition)
    flash[:notice] = t('admin.js.validations.password.success') if condition
    flash[:alert] = resource.errors.full_messages.first.to_s unless condition
  end

end
