class Animal < ApplicationRecord
  belongs_to :user
  has_one_attached :animal_image
  #has_many :genres
  has_many :animal_tags, dependent: :destroy
  has_many :tags, through: :animal_tags
  has_many :favorites, dependent: :destroy
  # has_many :animal_genres
  # has_many :genres, through: :animal_genres

  def self.search(params)
    animals = params[:animal].present? ? where("animalname like ?", "%#{params[:animal]}%") : Animal.all
    params[:keyword].present? ? animals.where("animalname like ? or category like ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") : animals
  end

  enum male_or_female: { male: 0, female: 1}

  # def save_tags(tags)
  #   current_tags = self.tags.pluck(:name) unless self.tags.nil?
  #   old_tags = current_tags - tags
  #   new_tags = tags - current_tags

  #   # Destroy old taggings:
  #   old_tags.each do |old_name|
  #     self.tags.delete Tag.find_by(name:old_name)
  #   end

  #   # Create new taggings:
  #   new_tags.each do |new_name|
  #     animal_tag = Tag.find_or_create_by(name:new_name)
  #     self.tags << animal_tag
  #   endß
end
