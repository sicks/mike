class UsersController < ApplicationController
  skip_before_filter :require_main, only: [:update]

  def home

  end

  def update
    current_user.update(user_params)

    if current_user.save
      flash_message(:notice, "update User success")
      redirect_to request.referrer
    else
      flash_message(:notice, "update User failed")
      render request.referrer
    end
  end

  private
  def user_params
    params.require(:user).permit(:main_id)
  end
end
