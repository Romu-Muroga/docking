class AddLikesCountToPosts < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :likes_count, :integer, null: false, default: 0 unless column_exists? :posts, :likes_count
  end

  def down
    remove_column :posts, :likes_count if column_exists? :posts, :likes_count
  end
end
