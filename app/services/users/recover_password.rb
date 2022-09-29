class Users::RecoverPassword < BusinessProcess::Base
  needs :user

  steps :fetch_user,
        :send_mailer

  def call
    process_steps
    @user
  end

  def fetch_user
    @user = user
  end

  def send_mailer
    new_password = Devise.friendly_token.last(7)

    ::PasswordMailer.send_new_password(@user.id, new_password).deliver_now if @user.update(password: new_password)
  end

  def verify_error
    fail(@user.errors.full_messages) if @user.persisted?
  end

end
