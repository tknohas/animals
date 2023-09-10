class AddCategoryToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :category, :string
  end
end
