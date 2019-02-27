class UserController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :user_allowed?, only: [:show]

  def show
    @user = User.find(params[:id])
  end
end


  private

  def user_allowed?
  	unless current_user == User.find(params[:id])
  		flash[:danger] = "Tu n'es pas autorisée à accéder à ceci"
  		redirect_to root_path
  	end
  end
