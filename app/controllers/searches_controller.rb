class SearchesController < ApplicationController
  before_action :set_user

  def new
    @search = Search.new
    @publishers = Collectible.distinct.pluck(:publisher)
    @conditions = Collectible.distinct.pluck(:condition)
  end

  def create
    @search = Search.create(search_params)
    redirect_to user_search_path(current_user, @search)
  end

  def show
    @search = Search.find(params[:id])
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def search_params
    params.require(:search).permit(:keywords, :publisher, :min_price, :max_price, :year, :condition)
  end
end
