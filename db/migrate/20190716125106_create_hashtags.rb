class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.string :hashname, null: false
      t.timestamps
    end
    add_index :hashtags, :hashname, unique: true
  end
end
