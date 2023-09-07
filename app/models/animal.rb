class Animal < ApplicationRecord
  belongs_to :user
  has_one_attached :animal_image
  belongs_to :genre
  # has_many :animal_tags, dependent: :destroy
  # has_many :tags, through: :animal_tags, dependent: destroy

  def self.search(params)
    animals = params[:animal].present? ? where("animalname like ?", "%#{params[:animal]}%") : Animal.all
    params[:keyword].present? ? animals.where("animalname like ? or body like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") : animals
  end

  enum male_or_female: { male: 0, female: 1}
end
