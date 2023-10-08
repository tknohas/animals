class CreateAnimalGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_genres do |t|
      t.integer :animal_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
