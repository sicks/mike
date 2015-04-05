class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def user_signed_in?
    !session[:user_id].nil?
  end

  def authenticate_user
    redirect_to login_path unless user_signed_in?
  end
end
