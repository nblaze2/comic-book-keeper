class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: true,
            :email_format => { :message => ' is not a valid email address.' }
  validates :name, presence: true, length: { maximum: 100 }
  has_many :collectibles, dependent: :destroy

  def admin?
    admin
  end
end
