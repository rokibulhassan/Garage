class UserMailer < ActionMailer::Base
  layout  'mail'
  default from: 'MyyGarage <admin@myygarage.dev>'


  def confirmation(user)
    I18n.locale = user.locale
    recipient   = "#{user.username} <#{user.email}>"

    @user             = user
    @confirmation_url = user_confirm_url(@user, confirmation_token: @user.confirmation_token)

    mail to: recipient, subject: t('users.confirmation.email_subject')
  end


  def password_recovery(user)
    I18n.locale = user.locale
    recipient   = "#{user.username} <#{user.email}>"

    @user         = user
    @recovery_url = user_reset_password_url(@user, password_recovery_token: @user.password_recovery_token)

    mail to: recipient, subject: t('users.password_recovery.email_subject')
  end
end
