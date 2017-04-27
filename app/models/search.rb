class Search < ApplicationRecord

  def search_collectibles(user)
    if user.admin?
      user = User.find(params[:user_id])
      collectibles = user.collectibles
    else # should be elsif?
      collectibles = user.collectibles
    end

    collectibles = collectibles.where('name_of_item ILIKE :search OR
    story_title ILIKE :search OR writer ILIKE :search OR
    artist ILIKE :search OR artist2 ILIKE :search OR
    artist3 ILIKE :search OR cover_artist ILIKE :search
    OR notes ILIKE :search', search: "%#{keywords}%") if keywords.present?
    collectibles = collectibles.where(["media LIKE ?", media]) if media.present?
    collectibles = collectibles.where(["publisher LIKE ?", publisher]) if publisher.present?
    collectibles = collectibles.where(["year = ?", year]) if year.present?
    collectibles = collectibles.where(["est_value >= ?", min_price]) if min_price.present?
    collectibles = collectibles.where(["est_value <= ?", max_price]) if max_price.present?
    collectibles = collectibles.where(["condition LIKE ?", condition]) if condition.present?

    return collectibles
  end
end
