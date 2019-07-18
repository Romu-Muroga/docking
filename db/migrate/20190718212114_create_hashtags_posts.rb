class CreateHashtagsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags_posts, id: false do |t|
      t.references :post, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.references :hashtag, index: true, foreign_key: { on_delete: :cascade }, null: false
    end
  end
end
