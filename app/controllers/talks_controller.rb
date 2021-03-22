class TalksController < ApplicationController
  def index
    @talk = Talk.new
    @room = Room.find(params[:room_id])
    @talks = @room.talks.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @talk = @room.talks.new(talk_params)
    if @talk.save
      redirect_to room_talks_path(@room)
    else
      @talks = @room.talks.includes(:user)
      render :index
    end
  end

  private

  def talk_params
    params.require(:talk).permit(:content, :image).merge(user_id: current_user.id, room_id: @room.id)
  end
end
