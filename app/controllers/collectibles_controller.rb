class CollectiblesController < ApplicationController
  before_action :set_collectible, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: [:index]
  before_action :set_user_index, only: [:index]
  before_action :authenticate_user

  def index
    # @collectibles = current_user.view_collectibles(User.find(params[:user_id]))

  end

  def show
  end

  def new
    if params[:format]
      collectible_id = params[:format]
      @collectible = Collectible.find(collectible_id)
      @collectible = Collectible.new(@collectible.attributes)
    else
      @collectible = Collectible.new(user: @user)
    end
  end

  def edit
  end

  def create
    @collectible = @user.collectibles.new(collectible_params)
    @collectible.user = current_user

    if @collectible.save
      redirect_to user_collectibles_path(current_user), notice: 'Collectible was successfully created.'
    else
      render :new
    end
  end

  def update
    if @collectible.update(collectible_params)
      redirect_to user_collectible_path(@user, @collectible), notice: 'Collectible was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @collectible.destroy
    redirect_to user_collectibles_path(@user, @collectibles), notice: 'Collectible was successfully destroyed.'
  end

  private

  def set_collectible
    @collectible = Collectible.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def collectible_params
    params.require(:collectible).permit(
      :keep, :year, :media, :name_of_item,
      :story_title, :vol_num, :issue_num,
      :publisher, :writer, :cover_artist,
      :artist, :artist2, :artist3, :condition,
      :est_value, :notes)
  end

  def user_search
    @user.collectibles.search(params[:search]).order(name_of_item: :asc)
  end

  def set_user_index
    if params[:user_id]
      if current_user.admin?
        @user = User.find(params[:user_id])
        @collectibles = user_search
      else
        @user = current_user
        @collectibles = user_search
      end
    else
      redirect_to new_user_session_path, notice: 'You must be signed in.'
    end
  end

  def authenticate_user
    if !user_signed_in?
      redirect_to new_user_session_path, notice: "You must be logged in."
    end
  end

  def authorize_user
    if @collectible.user != current_user
      if !current_user.admin?
        redirect_to collectible_path(@collectible), notice: "You are not authorized to make those changes."
      end
    end
  end
end
