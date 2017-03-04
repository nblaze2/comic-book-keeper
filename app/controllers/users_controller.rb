class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all.order(name: :asc)
    else
      redirect_to '/'
    end
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      redirect_to '/'
    else
      redirect_to '/', notice: 'You are not authorized to do that action.'
    end
  end
end
