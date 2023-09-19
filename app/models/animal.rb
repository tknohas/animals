class Animal < ApplicationRecord
  belongs_to :user
  has_many_attached :animal_images
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags
  has_many :favorites, dependent: :destroy
  
  def self.search(params)
    animals = params[:animal].present? ? where("animalname like ?", "%#{params[:animal]}%") : Animal.all
    params[:keyword].present? ? animals.where("animalname like ? or category like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") : animals
  end

  enum male_or_female: { male: 0, female: 1}

  with_options presence: true do
    validates :animalname
    validates :body
    validates :animal_images
    validates :category
  end
end
