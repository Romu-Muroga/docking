require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:test_user_01) { create(:user) }
  let!(:washoku) { create(:category) }
  let!(:ramen) { create(:second_category) }
  it 'ranking_pointが空だとバリデーションが通らない' do
    post = Post.new(
      ranking_point: '',
      eatery_name: 'test',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      category: washoku,
      user: test_user_01
    )
    # be_validでvalid?メソッドを呼んで、それが返す値が（真 = true）ではない（not_to）ことを期待するテスト
    expect(post).not_to be_valid
  end

  it 'eatery_nameが201文字以上または空だとバリデーションが通らない' do
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'a' * 201,
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
    post = Post.new(
      ranking_point: 3,
      eatery_name: '',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end

  it 'eatery_foodが201文字以上または空だとバリデーションが通らない' do
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: 'a' * 201,
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: '',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end

  it 'eatery_addressが501文字以上だとバリデーションが通らない' do
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: 'test',
      eatery_address: 'a' * 501,
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end

  it 'user_idとcaregory_idとranking_pointが同じ組み合わせで登録しようとするとバリデーションが通らない' do
    Post.create!(
      ranking_point: 3,
      eatery_name: '先に登録したデータ',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    post = Post.new(
      ranking_point: 3,
      eatery_name: '同カテゴリー、同順位で登録しようとしている',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end

  it 'eatery_websiteが501文字以上または不正なフォーマットだとバリデーションが通らない' do
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: "https://#{'a' * 501}@dic.com",
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '不正なフォーマット',
      remarks: 'test',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end

  it 'remarksが空だとバリデーションが通らない' do
    post = Post.new(
      ranking_point: 3,
      eatery_name: 'test',
      eatery_food: 'test',
      eatery_address: '',
      eatery_website: '',
      remarks: '',
      likes_count: 0,
      category: washoku,
      user: test_user_01
    )
    expect(post).not_to be_valid
  end
end
