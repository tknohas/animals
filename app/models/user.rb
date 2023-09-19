class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :user_image
  has_many :animals, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def already_favorited?(animal)
    self.favorites.exists?(animal_id: animal.id)
  end

  validates :username, presence: true
end
