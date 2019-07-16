class CreatePostHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_hashtags do |t|
      t.references :post, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.references :hashtag, index: true, foreign_key: { on_delete: :cascade }, null: false
    end
  end
end
