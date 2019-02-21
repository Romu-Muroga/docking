class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :ranking_point, null: false
      t.string :eatery_name, null: false, limit: 200
      t.string :eatery_food, null: false, limit: 200
      t.string :eatery_address, null: false, limit: 500
      t.decimal :latitude, precision: 11, scale: 8
      t.decimal :longitude, precision: 11, scale: 8
      t.string :eatery_website, null: false, limit: 500
      t.text :remarks, null: false
      t.references :category, index: true, foreign_key: { on_delete: :cascade }
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
