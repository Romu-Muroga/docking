require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:test_user_01) { create(:user) }
  let!(:washoku) { create(:category) }
  let!(:washoku_restaurant) { create(:post, category: washoku, user: test_user_01) }
  it 'contentが空だとバリデーションが通らない' do
    comment = Comment.new(
      content: '',
      post: washoku_restaurant,
      user: test_user_01
    )
    expect(comment).not_to be_valid
  end
end
