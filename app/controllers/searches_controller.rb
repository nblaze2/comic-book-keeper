class SearchesController < ApplicationController
  before_action :set_user

  def new
    @search = Search.new
    @users = User.distinct.pluck(:name)
    @media = Collectible.distinct.pluck(:media)
    @publishers = Collectible.distinct.pluck(:publisher)
    @conditions = Collectible.distinct.pluck(:condition)
  end

  def create
    binding.pry
    if current_user.admin?
      # @user =
    end
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
    params.require(:search).permit(:user_id, :keywords, :media, :publisher, :min_price, :max_price, :year, :condition)
  end
end
