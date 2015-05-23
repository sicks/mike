class PayoutsController < ApplicationController

  def index
    @payout = current_corp.payouts.build

    @payouts = current_corp.payouts.persisted
  end

  def new
    @payout = current_corp.payouts.build(payout_params)

    @unpaid_ops = current_corp.ops.where(payout_id: nil)
    @payout.ops << @unpaid_ops
  end

  def create
    @payout = current_corp.payouts.create(payout_params)
    @payout.ops << current_corp.ops.find(params[:ops])

    if @payout.save
      flash_message(:notice, "new Payout successful")
      redirect_to payouts_path
    else
      flash_message(:alert, "new Payout failed")
      render :new
    end
  end

  private
  def payout_params
    params.require(:payout).permit(:amount_payable)
  end
end
