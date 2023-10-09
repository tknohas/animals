class Animal < ApplicationRecord
  belongs_to :user
  has_many_attached :animal_images
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags
  has_many :favorites, dependent: :destroy

  def self.search(params)
    if params[:keyword].present?
      where("animalname like ? or category like ?", "%#{params[:keyword]}%",
      "%#{params[:keyword]}%")
    else
      Animal.all
    end
  end
  enum male_or_female: { male: 0, female: 1 }

  with_options presence: true do
    validates :animalname
    validates :body
    validates :category
    validates :animal_images
  end
  validates :body, length: { maximum: 140 }
  validates :animalname, length: { maximum: 20 }
  validate :animal_images_length

  def animal_images_length
    if animal_images.length > 4
      errors.add(:animal_images, "は4枚以内で選択してください")
    end
  end
end
