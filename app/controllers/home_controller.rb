class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to '/pages/home'
    elsif current_user.admin?
      redirect_to '/users'
    elsif current_user
      # binding.pry
      redirect_to user_collectibles_path(current_user)
    end
  end

  def faq
    redirect_to '/faq'
  end

  def home
    redirect_to '/home'
  end
end
