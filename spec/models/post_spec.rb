require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category)
    @category2 = FactoryBot.create(:second_category)
  end

  it "内容が空だとバリデーションが通らない" do
    post = Post.new(
      ranking_point: "",
      eatery_name: "失敗テスト",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------"
    )
    expect(post).not_to be_valid#be_validでvalid?メソッドを呼んで、それが返す値が（真 = true）ではない（not_to）ことを期待するテスト
  end

  it "全ての内容が記載されていればバリデーションが通る" do
    post = Post.new(
      ranking_point: 3,
      eatery_name: "成功テスト",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    expect(post).to be_valid#be_validでvalid?メソッドを呼んで、それが返す値が（真 = true）である（to）ことを期待するテスト
  end

  it "user_idとcaregory_idとranking_pointが同じ組み合わせで登録しようとするとバリデーションが通らないテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "先に登録したデータ",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.new(
      ranking_point: 3,
      eatery_name: "post1と同カテゴリー、同順位で登録しようとしている",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    expect(post2.save).to eq false
  end

  it "更新順に並び替えができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "後",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "先",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    posts = Post.latest
    expect(posts[0]).to eq post2
    expect(posts[1]).to eq post1
  end

  it "カテゴリーでソートができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "当たり",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "ハズレ",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user_id: @user1.id
    )
    posts = Post.category_sort(@category1.id)
    expect(posts).to include post1
  end

  it "いいねランキングでソートできるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "１位",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 100,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "２位",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    posts = Post.iine_ranking
    expect(posts[0]).to eq post1
  end

  it "所在地とカテゴリーと順位と店名の全てに値が入っていた場合の検索ができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "和食レストラン",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.all_search("東京都渋谷区", @category1, 3, "和食レストラン")
    expect(posts).to include post1
  end

  it "所在地で検索ができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.address_search("東京都渋谷区")
    expect(posts).to include post1
  end

  it "カテゴリーで検索ができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.category_search(@category2)
    expect(posts).to include post2
  end

  it "順位で検索ができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.rank_search(2)
    expect(posts).to include post2
  end

  it "ユーザーが投稿したもので、カテゴリーでソートができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.user_category_sort(@user1, @category1)
    expect(posts).to include post1
  end

  it "ユーザーがマイページを訪れたときのデフォルトのソートができるかテスト" do
    post1 = Post.create!(
      ranking_point: 3,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "東京都渋谷区",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category: @category1,
      user: @user1
    )
    post2 = Post.create!(
      ranking_point: 2,
      eatery_name: "-------",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: @category2.id,
      user: @user1
    )
    posts = Post.default_sort
    expect(posts).to include post1
  end
end
