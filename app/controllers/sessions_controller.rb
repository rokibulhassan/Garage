class SessionsController < ApplicationController
  # TODO: Use i18n messages.
  def create
    if identified_user
      if sign_user_in(identified_user, given_password)
        #TODO: respond to JSON
        redirect_to root_path
      else
        redirect_to root_path, alert: 'Sign in failed!'
      end
    else
      redirect_to root_path, alert: 'User not found!'
    end
  end


  def destroy
    self.current_user = nil
    redirect_to root_path
  end
end
