class Collectible < ApplicationRecord
  validates :keep, presence: true,
            inclusion: { in: [true, false] }
  validates :year, presence: true,
            numericality: true,
            length: { is: 4 }
  validates :media,
            presence: true,
            inclusion: { in: %w(comic book magazine other) }
  validates :name_of_item,
            presence: true,
            length: { maximum: 75 }
  validates :story_title, length: { maximum: 100 }
  validates :vol_num, numericality: true
  validates :issue_num, numericality: true
  validates :publisher, length: { maximum: 75 }
  validates :writer, length: { maximum: 75 }
  validates :cover_artist, length: { maximum: 75 }
  validates :artist, length: { maximum: 75 }
  validates :artist2, length: { maximum: 75 }
  validates :artist3, length: { maximum: 75 }
  validates :condition, inclusion: { in: %w(NM VF FN VG GD FR PR) }
  validates :est_value, numericality: true
  validates :notes, length: { maximum: 500 }

  belongs_to :user
end
