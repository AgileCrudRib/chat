class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:name].blank? || params[:password].blank?
	  Rails.logger.debug("Error: Missing arguments")
	  return
	end

    user = User.find_by(name: params[:name])

    if user.nil?
      user = User.create(name: params[:name], password: params[:password])

      if user.persisted?
        session[:user_id] = user.id
        redirect_to rooms_join_path
      else
        Rails.logger.debug("Error: Failed to create account")
      end
    else
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to rooms_join_path
      else
        Rails.logger.debug("Error: Wrong password")
      end
    end
  end
end