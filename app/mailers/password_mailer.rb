class PasswordMailer < ApplicationMailer
  def send_new_password_mailer(user)
    @user = user
    @layout_subject = I18n.t('mail.recovery_password.subject')

    mail(to: @user.email, subject: @layout_subject)
  end

end
