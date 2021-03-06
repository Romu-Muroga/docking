class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :post, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.references :user, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.timestamps
    end
  end
end
