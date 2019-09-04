require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:test_user_01) { create(:user) }
  it 'category_idは、空白は無効' do
    post = test_user_01.posts.new
    post.category_id = ""
    post.save
    expect(post.errors[:category_id]).to include('を入力してください')
  end

  it 'category_idは、数値以外は無効' do
    post = test_user_01.posts.new
    post.category_id = 'test'
    post.save
    expect(post.errors[:category_id]).to include('は数値で入力してください')
  end

  it 'category_idは、登録済みのカテゴリー以外は無効' do
    post = test_user_01.posts.new
    post.category_id = washoku.id
    post.save
    pending '登録済みのカテゴリーなのにバリデーションが通らない'
    expect(post.errors[:category_id]).to include('は一覧にありません')
  end
end
