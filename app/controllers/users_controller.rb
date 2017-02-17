class UsersController < ApplicationController
  def index
    # if current_user.admin?
    #   @users = User.all.order(email: :asc)
    #   @movies = Movie.all.order(title: :asc)
    #   @reviews = Review.all.order(updated_at: :desc)
    # else
    #   redirect_to '/movies'
    # end
  end
end
