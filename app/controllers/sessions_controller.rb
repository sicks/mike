class SessionsController < ApplicationController
  skip_before_filter :authenticate_user
  skip_before_filter :require_api_keys

  def new
    redirect_to root_path if user_signed_in?
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    flash_message :notice, "login success"
    redirect_to root_url
  end

  def destroy
    reset_session
    flash_message :notice, "logout success"
    redirect_to login_path
  end

end
