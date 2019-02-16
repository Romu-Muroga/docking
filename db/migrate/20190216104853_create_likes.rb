class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :post, index: true, foreign_key: { on_delete: :cascade }
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
