class Collectible < ApplicationRecord
  validates :keep, inclusion: { in: [true, false] }
  validates :year, presence: true,
            numericality: true,
            length: { is: 4 }
  validates :media,
            presence: true
  validates :name_of_item,
            presence: true,
            length: { maximum: 75 }
  validates :story_title, length: { maximum: 100 }
  validates :vol_num, numericality: true, allow_nil: true
  validates :issue_num, numericality: true, allow_nil: true
  validates :publisher, length: { maximum: 75 }
  validates :writer, length: { maximum: 75 }
  validates :cover_artist, length: { maximum: 75 }
  validates :artist, length: { maximum: 75 }
  validates :artist2, length: { maximum: 75 }
  validates :artist3, length: { maximum: 75 }
  validates :condition, inclusion: { in: %w(NM VF FN VG GD FR PR) }, allow_nil: true
  validates :est_value, numericality: true, allow_nil: true
  validates :notes, length: { maximum: 500 }

  belongs_to :user

  def self.search(search)
    if search
      where(["name_of_item ILIKE ?", "%#{search}%"])
    else
      all
    end
  end
end
