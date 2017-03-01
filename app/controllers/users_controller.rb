class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all.order(name: :asc)
    else
      redirect_to '/'
    end
  end
end
