class DropGenres < ActiveRecord::Migration[6.1]
  def change
    drop_table "genres" do |t|
      t.string "name", null: false
      t.string "ancestry"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
