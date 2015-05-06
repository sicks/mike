class OpsController < ApplicationController
  before_action :get_op, only: [:show, :edit, :update, :destroy]

  def index

  end

  def new
    @op = Op.prepare(current_user)
  end

  def create
    @op = Op.create(op_params)
    @op.user = current_user

    if @op.save
      flash_message :notice, "add Op success"
      redirect_to ops_path
    else
      flash_message :notice, "add Op failed"
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    @op.update(op_params)
    flash_message(:notice, "update Op successful")
    redirect_to op_path(@op)
  end

  def conclude
    @op = Op.where(corp_id: current_user.corps.map{ |c| c.id} ).find(params[:op_id])
    @op.end_time = DateTime.now

    if @op.save
      flash_message(:notice, "Op ended successfully at #{@op.end_time}")
      redirect_to ops_path
    else
      flash_message(:notice, "failed to end Op")
      redirect_to op_path(@op)
    end
  end

  def destroy
    @op.destroy
    flash_message(:notice, "delete Op successful")
    redirect_to ops_path
  end

  private
  def op_params
    params.require(:op).permit(:corp_id, :name, :start_time, :end_time)
  end

  def get_op
    @op ||= Op.where(corp_id: current_user.corps.map{ |c| c.id} ).find(params[:id])
  end
end
