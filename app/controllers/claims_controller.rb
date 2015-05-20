class ClaimsController < ApplicationController
  before_action :get_op, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_claim, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @claim = @op.claims.build
  end

  def create
    @claim = @op.claims.create(claim_params)

    if @claim.save
      flash_message(:notice, "add claim success")
      redirect_to op_path(@op)
    else
      flash_message(:alert, "add claim failed")
      render :new
    end
  end

  def edit

  end

  def update
    @claim.update(claim_params)

    if @claim.save
      flash_message(:notice, "update claim success")
      redirect_to op_path(@op)
    else
      flash_message(:alert, "update claim failed")
      render :new
    end
  end

  def destroy
    if @claim.destroy
      flash_message(:notice, "delete claim success")
      redirect_to op_path(@op)
    else
      flash_message(:alert, "delete claim failed")
      redirect_to request.referrer
    end
  end

  private
  def claim_params
    params.require(:claim).permit(:op_id, :claimable_id, :quantity)
  end

  def get_op
    @op = Op.where(corp_id: current_corp.id).find(params[:op_id])
  end

  def get_claim
    @claim = @op.claims.find(params[:id])
  end
end
