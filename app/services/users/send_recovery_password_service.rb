class Users::SendRecoveryPasswordService < BusinessProcess::Base
  TEMPORARY_PASSWORD_LENGTH = 6

  needs :email

  steps :find_user,
        :dispatch_new_password_if_needed,
        :verify_errors

  def call
    process_steps
    @user
  end

  private

  def find_user
    @user = User.find_for_database_authentication(email: email)
  end

  def dispatch_new_password_if_needed
    return unless @user.present?

    generate_temporary_password
    send_recovery_password
  end

  def generate_temporary_password
    temp_pass = Devise.friendly_token(TEMPORARY_PASSWORD_LENGTH).downcase
    @user.update(
      password: temp_pass,
      temporary_password: temp_pass,
      reset_password_sent_at: DateTime.current
    )
  end

  def send_recovery_password
    PasswordMailer.send_new_password_mailer(@user).deliver_now
  end

  def verify_errors
    fail([I18n.t('services.session_service.errors.user_not_found')]) unless @user.present?
  end

end
