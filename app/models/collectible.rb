class Collectible < ApplicationRecord
  validates :year, presence: true,
            numericality: true,
            length: { is: 4 }
  validates :media,
            presence: true,
            inclusion: { in: %w('comic book' book print ) }
  validates :title,
            presence: true,
            length: { maximum: 75 }
  validates :issue_num, numericality: true
  validates :publisher, length: { maximum: 75 }
  validates :writer, length: { maximum: 75 }
  validates :artist, length: { maximum: 75 }
  validates :condition, inclusion: { in: %w(NM VF FN VG GD FR PR) }
  validates :value, numericality: true
  validates :desciption, length: { maximum: 500 }

  belongs_to :user
end
