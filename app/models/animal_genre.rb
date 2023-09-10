class AnimalGenre < ApplicationRecord
  belongs_to :animal
  belongs_to :genre

  def self.maltilevel_genre_create(animal, parent_id, children_id, grandchildren_id)
    if parent_id.present? && parent_id != '---'
      genre = Genre.find(parent_id)
      AnimalGenre.create(animal_id: animal.id, genre_id: genre.id)
    end

    if children_id.present? && children_id != '---'
      genre = Genre.find(children_id)
      AnimalGenre.create(animal_id: animal.id, genre_id: genre.id)
    end

    if grandchildren_id.present? && grandchildren_id != '---'
      genre = Genre.find(grandchildren_id)
      AnimalGenre.create(animal_id: animal.id, genre_id: genre.id)
    end
  end
end
