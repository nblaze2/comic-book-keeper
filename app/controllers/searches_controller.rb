class SearchesController < ApplicationController
  before_action :set_user

  def new
    @search = Search.new
    @users = User.all.distinct
    @media = Collectible.distinct.pluck(:media)
    @publishers = Collectible.distinct.pluck(:publisher)
    @conditions = Collectible.distinct.pluck(:condition)
  end

  def create
    if current_user.admin?
      @user = User.where(name: "#{search_params[:name]}")
      @search = Search.create(search_params)
      redirect_to user_search_path(@user[0].id, @search)
    else
      @search = Search.create(search_params)
      redirect_to user_search_path(current_user, @search)
    end
  end

  def show
    @search = Search.find(params[:id])
  end

  private
  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def search_params
    params.require(:search).permit(:name, :keywords, :media, :publisher, :min_price, :max_price, :year, :condition)
  end
end
