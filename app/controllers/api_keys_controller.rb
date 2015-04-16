class ApiKeysController < ApplicationController

  skip_before_filter :require_api_keys, only: [:new, :create]

  def index

  end

  def new
    @api_key = current_user.api_keys.build
  end

  def create
    @api_key = current_user.api_keys.create(api_key_params)

    if @api_key.save
      redirect_to api_keys_path, notice: "API Key added"
    else
      render :new, notice: "Something's wrong with provided key."
    end
  end

  def destroy
    current_user.api_keys.find(params[:id]).destroy
    redirect_to api_keys_path, notice: "API Key deleted."
  end

  private
  def api_key_params
    params.require(:api_key).permit(:vcode, :key_id)
  end
end
