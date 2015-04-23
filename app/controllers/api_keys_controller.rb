class ApiKeysController < ApplicationController

  skip_before_filter :require_api_keys, only: [:new, :create]

  def index
    @api_keys = current_user.api_keys
  end

  def new
    @api_key = current_user.api_keys.build
  end

  def create
    @api_key = current_user.api_keys.create(api_key_params)

    if @api_key.save
      flash_message :notice, "add API Key success"
      redirect_to api_keys_path
    else
      flash_message :notice, "add API Key failed"
      render :new
    end
  end

  def destroy
    current_user.api_keys.find(params[:id]).destroy
    flash_message :notice, "delete API Key success"
    redirect_to api_keys_path
  end

  private
  def api_key_params
    params.require(:api_key).permit(:vcode, :key_id)
  end
end
