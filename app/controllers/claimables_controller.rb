class ClaimablesController < ApplicationController
  before_action :get_claimable, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @claimable = current_corp.claimables.build( weight: 1 )
  end

  def create
    @claimable = current_corp.claimables.create(claimable_params)

    if @claimable.save
      flash_message(:notice, "add Claimable success")
      redirect_to claimables_path
    else
      flash_message(:notice, "add Claimable failed")
      render :new
    end
  end

  def edit

  end

  def update
    @claimable.update(claimable_params)

    if @claimable.save
      flash_message(:notice, "update Claimable success")
      redirect_to claimables_path
    else
      flash_message(:notice, "update Claimable failed")
      render :new
    end
  end

  def destroy
    @claimable.destroy
    flash_message(:notice, "delete Claimable success")
    redirect_to claimables_path
  end

  private
  def claimable_params
    params.require(:claimable).permit(:corp_id, :name, :weight)
  end

  def get_claimable
    @claimable = current_corp.claimables.where(corp_id: current_corp.id).find(params[:id])
  end
end
