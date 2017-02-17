class HomeController < ApplicationController
  def index
    redirect_to '/collectibles'
  end

  def faq
    redirect_to '/about'
  end
end
