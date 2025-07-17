class RoomsController < ApplicationController
  before_action :validate_session

  def validate_session
    unless session[:user_id]
      redirect_to sessions_new_path
    end
  end

  def join
  end

  def create
    if params[:name].blank?
      Rails.logger.debug("Error: Missing arguments")
      redirect_to rooms_join_path
	  return
    end

    redirect_to rooms_show_path(name: params[:name])
  end

  def show
    @room = Room.find_or_create_by!(name: params[:name])

    unless @room.persisted?
      Rails.logger.debug("Error: Failed to create or join room")
      redirect_to rooms_join_path
    end

    @messages = Message.where(room_id: @room.id).order(:id)

    user_ids = @messages.map(&:user_id).uniq
    @user_names = User.where(id: user_ids).pluck(:id, :name).to_h
  end
end