class ParticipantsController < ApplicationController
  before_action :get_op
  before_action :get_participant, except: [:create]

  def create
    @participant = @op.participants.build(user: current_user, mod: 1.0)

    if @participant.save
      flash_message(:notice, "participating in #{@op.name}")
      redirect_to request.referrer
    else
      flash_message(:notice, "participation attempt failed")
      redirect_to request.referrer
    end
  end

  def update
    @participant.update(participant_params)
  end

  def destroy
    @participant.destroy
    flash_message(:notice, "participation withdrawn")
    redirect_to op_path(@op)
  end

  private
  def participant_params
    params.require(:participant).permit(:mod)
  end

  def get_op
    @op = Op.where(corp_id: current_user.corps.map{|c| c.id }).find(params[:op_id])
  end

  def get_participant
    @participant = @op.participants.find(params[:id])
  end
end
