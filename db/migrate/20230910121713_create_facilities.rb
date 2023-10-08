class CreateFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities do |t|
      t.string :facility_name
      t.text :introduction
      t.integer :user_id
      t.integer :animal_id
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
