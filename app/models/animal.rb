class Animal < ApplicationRecord
  belongs_to :user
  has_one_attached :animal_image

  def self.search(params)
    animals = params[:animal].present? ? where("animalname like ?", "%#{params[:animal]}%") : Animal.all
    params[:keyword].present? ? animals.where("animalname like ? or body like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") : animals
  end
end
