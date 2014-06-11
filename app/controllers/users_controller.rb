class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end


  def create
    @user                    = User.new(params[:user])
    @user.persistence_token  = UniqueToken.generate
    @user.confirmation_token = UniqueToken.generate
    @user.locale             = selected_locale || guessed_locale

    if @user.valid?
      UserLocalizer.new(@user, request.user_preferred_languages).execute
      @user.save!

      self.current_user = @user

      render :show
    else
      render json: false, status: 403
    end
  end


  def confirm
    @user = User.find(params[:user_id])

    if @user.nil?
      redirect_to root_path, alert: t('users.confirmation.user_not_found')

    elsif @user.confirmed?
      redirect_to root_path, alert: t('users.confirmation.account_already_confirmed')

    elsif @user.confirmation_token != params[:confirmation_token]
      redirect_to root_path, alert: t('users.confirmation.confirmation_does_not_match')

    else
      @user.confirmed          = true
      @user.confirmed_at       = Time.current
      @user.confirmation_token = nil
      @user.save!

      self.current_user = @user
      redirect_to root_path, notice: t('users.confirmation.account_confirmed')
    end
  end


  # The page can only be displayed if:
  #   - The user is found.
  #   - The user actually requested a password recovery.
  #   - The token match with the stored one.
  def reset_password
    @user = User.find(params[:user_id])

    if @user.nil?
      redirect_to root_path, alert: t('users.password_recovery.user_not_found')

    elsif !@user.requested_password_recovery?
      redirect_to root_path, alert: t('users.password_recovery.user_dit_not_requested_password_recovery')

    elsif @user.password_recovery_token != params[:password_recovery_token]
      redirect_to root_path, alert: t('users.password_recovery.token_does_not_match')
    end
  end


  # The password is changed only if:
  #   - The user is found.
  #   - The user actually requested a password recovery.
  #   - The token match with the stored one.
  #   - The password is valid.
  def execute_reset_password
    @user = User.find(params[:user_id])

    if @user.nil?
      redirect_to root_path, alert: t('users.password_recovery.user_not_found')

    elsif !@user.requested_password_recovery?
      redirect_to root_path, alert: t('users.password_recovery.user_dit_not_requested_password_recovery')

    elsif @user.password_recovery_token != params[:password_recovery_token]
      redirect_to root_path, alert: t('users.password_recovery.token_does_not_match')

    else
      @user.update_attributes!(params[:user])
      self.current_user = @user
      redirect_to root_path, alert: t('users.password_recovery.password_was_changed')
    end
  end


  def update
    @user = current_user
    label = params[:system_of_units_code]

    if @user.update_attributes(params[:user])
      if label
        @user.unit_system = BaseUnitSystem.where(:label => label).first
        @user.save!
      end
      render :show
    else
      render json: true, status: 403
    end
  end


  def update_avatar
    current_user.avatar = params[:avatar]
    current_user.save

    render json: { url: current_user.avatar.url(:normal) }
  end


  # TODO: Handle the limit cases, like:
  #   - The email is already used by another account.
  #   - ...
  def unbind_facebook_account
    current_user.facebook_id           = nil
    current_user.email                 = params[:user][:email]
    current_user.password              = params[:user][:password]
    current_user.password_confirmation = params[:user][:password_confirmation]

    render json: current_user.save
  end
end
