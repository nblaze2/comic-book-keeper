class CollectiblesController < ApplicationController
  before_action :set_collectible, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    if !current_user.admin?
      @collectibles = current_user.collectibles
    else
      @user = User.find(params[:user_id])
      @collectibles = @user.collectibles
    end
    # @media = { "Comic" => 1, "Magazine" => 2, "Book" => 3, "Other" => 4 }
    # if params[:search]
    #   @collectibles = Collectible.search(params[:search]).order(year: :desc)
    # else
    #   @collectibles = Collectible.all.order(year: :desc)
    # end
  end

  def show
  end

  def new
    @collectible = Collectible.new
  end

  def edit
  end

  def create
    @collectible = Collectible.new(collectible_params)
    @collectible.user = current_user

    if @collectible.save
      redirect_to @collectible, notice: 'Collectible was successfully created.'
      # prompt to add another entry?
    else
      render :new
    end
  end

  def update
    if @collectible.update(collectible_params)
      redirect_to @collectible, notice: 'Collectible was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @collectible.destroy
    redirect_to collectibles_url, notice: 'Collectible was successfully destroyed.'
  end

  private

  def set_collectible
    @collectible = Collectible.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def collectible_params
    params.require(:collectible).permit(
      :keep, :year, :media, :name_of_item,
      :story_title, :vol_num, :issue_num,
      :publisher, :writer, :cover_artist,
      :artist, :artist2, :artist3, :condition,
      :est_value, :notes)
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
