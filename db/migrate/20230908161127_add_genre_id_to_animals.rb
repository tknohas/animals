class AddGenreIdToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :genre_id, :integer
  end
end
