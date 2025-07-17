class MessagesController < ApplicationController
  before_action :validate_session

  def validate_session
    unless session[:user_id]
      redirect_to sessions_new_path
	else
	  @user_id = session[:user_id]
    end
  end

  def create  
    if params[:content].blank? || params[:room_id].blank?
	  Rails.logger.debug("Error: Missing arguments")
	  return
	end
  
    @message = Message.new(
      content: params[:content],
      room_id: params[:room_id],
      user_id: @user_id
    )

    unless @message.save
      Rails.logger.debug("Error: Failed to create message")
    end
  end
end