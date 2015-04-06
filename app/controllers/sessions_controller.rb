class SessionsController < ApplicationController
  skip_before_filter :authenticate_user

  def new
    redirect_to root_path if user_signed_in?
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Login Successful."
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Logout Successful."
  end

end
