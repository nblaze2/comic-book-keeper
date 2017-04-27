class SearchesController < ApplicationController
  before_action :set_user

  def new
    @search = Search.new
    @media = Collectible.distinct.pluck(:media)
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
    params.require(:search).permit(:keywords, :media, :publisher, :min_price, :max_price, :year, :condition)
  end
end
