class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to '/collectibles'
    elsif current_user.admin?
      redirect_to '/users'
    else
      redirect_to '/collectibles'
    end
  end

  def faq
    redirect_to '/faq'
  end
end
