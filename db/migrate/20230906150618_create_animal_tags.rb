class CreateAnimalTags < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_tags do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
