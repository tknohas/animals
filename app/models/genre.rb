class Genre < ApplicationRecord
  # has_many :animal_genres
  # has_many :animals, through: :animal_genres
  has_ancestry
  belongs_to :animal

  def self.genre_parent_array_create
    genre_parent_array = ['---']
    Genre.where(ancestry: nil).each do |parent|
      genre_parent_array << [parent.name, parent.id]
    end
    return genre_parent_array
  end
end
