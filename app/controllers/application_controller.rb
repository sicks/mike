class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  before_action :require_api_keys

  def authenticate_user
    unless user_signed_in?
      flash_message :notice, 'login required'
      redirect_to login_path
    end
  end

  def require_api_keys
    if current_user.api_keys.empty?
      flash_message :notice, 'an api key is required'
      redirect_to new_api_key_path
    end
  end
end
