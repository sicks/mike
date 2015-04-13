class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  before_action :require_api_keys

  def authenticate_user
    redirect_to login_path unless user_signed_in?
  end

  def require_api_keys
    redirect_to new_api_key_path, notice: 'Add an API key to access corp tools.' if current_user.api_keys.empty?
  end
end
