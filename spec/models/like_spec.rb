require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:test_user_01) { create(:user) }
  let!(:washoku) { create(:category) }
  let!(:washoku_restaurant) { create(:post, category: washoku, user: test_user_01) }
  it '同じ投稿にいいね！しようとするとバリデーションが通らない' do
    create(:like, post: washoku_restaurant, user: test_user_01)
    like = Like.new(post: washoku_restaurant, user: test_user_01)
    expect(like.save).to eq false
  end

  it 'post_idまたはuser_idがnilだとバリデーションが通らない' do
    like = Like.new(post: nil, user: nil)
    expect(like.save).to eq false
  end
end
