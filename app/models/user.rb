class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :user_image
  has_many :animals, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :facilities, dependent: :destroy

  def already_favorited?(animal)
    favorites.exists?(animal_id: animal.id)
  end

  validates :username, presence: true
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト"
    end
  end
end
