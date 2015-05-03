class ClaimsController < ApplicationController
  before_action :get_op, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_claim, only: [:edit, :update, :destroy]

  def new
    @claim = @op.claims.build
  end

  def create
    @claim = @op.claims.create(claim_params)

    if @claim.save
      flash_message(:notice, "add Claim success")
      redirect_to op_path(@op)
    else
      flash_message(:notice, "add Claim failed")
      render :new
    end
  end

  def edit

  end

  def update
    @claim.update(claim_params)

    if @claim.save
      flash_message(:notice, "update Claim success")
      redirect_to op_path(@op)
    else
      flash_message(:notice, "update Claim failed")
      render :new
    end
  end

  def destroy
    @claim.destroy
    redirect_to op_path(@op)
  end

  private
  def claim_params
    params.require(:claim).permit(:op_id, :claimable_id, :quantity)
  end

  def get_op
    @op = Op.where(corp_id: current_user.corps.map{|c| c.id }).find(params[:op_id])
  end

  def get_claim
    @claim = @op.claims.find(params[:id])
  end
end
