class PasswordsController < ApplicationController
  def new
  end


  def create
    email = params[:password][:email]
    @user = email.present? && User.with_email.find_by_email(email)

    if @user.blank?
      flash.now[:alert] = t('users.password_recovery.user_not_found')
      render :new
    else @user
      @user.password_recovery_token = UniqueToken.generate
      @user.save!
      UserMailer.password_recovery(@user).deliver
    end
  end
end
