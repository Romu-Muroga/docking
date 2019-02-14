class AddUniquePostsRankingpointCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, [:ranking_point, :category_id], unique: true
  end
end
