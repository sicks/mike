class OpsController < ApplicationController

  def index
    current_user.corporations.each do |c|
      @corps ||= []
      @corps << Corp.find_or_create_by(name: c.name, ccp_id: c.ccp_id)
    end
  end

  def new
    @op = Op.new(start: DateTime.now)
  end

  def create
    @op = Op.create(op_params)

    if @op.save
      flash_message :notice, "add Op success"
      redirect_to ops_path
    else
      flash_message :notice, "add Op failed"
      render :new
    end
  end

  private
  def op_params
    params.require(:op).permit(:corp_id, :name, :start)
  end
end
