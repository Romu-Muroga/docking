class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.text :image, null: false
      t.references :imageable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
