class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.integer :user_id
      t.string :animalname
      t.text :body
      t.string :animal_image_id
      t.integer :male_or_female
      t.timestamps
    end
  end
end
