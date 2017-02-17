class CollectiblesController < ApplicationController
  def index
    @collectibles = Collectible.all
  end
end
