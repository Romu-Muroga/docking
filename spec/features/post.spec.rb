require "rails_helper"

RSpec.feature "投稿機能", type: :feature do
  # save_and_open_page
  # ユーザー
  user1 = FactoryBot.create(:user)
  user2 = FactoryBot.create(:second_user)
  # カテゴリー
  category1 = FactoryBot.create(:category)# 和食
  # category2 = FactoryBot.create(:second_category)# ラーメン・麺類
  category2 = Category.create(name: "ラーメン・麺類")
  # ポスト
  post1 = FactoryBot.create(:post, user: user1, category: category1)
  post2 = FactoryBot.create(:second_post, user: user1, category: category2)
  # 写真
  FactoryBot.create(:picture, imageable_id: post1.id, imageable_type: post1.class)
  FactoryBot.create(:second_picture, imageable_id: post2.id, imageable_type: post2.class)
  # いいね
  # FactoryBot.create(:post_like, post: post1, user: user1)

  def login(email)
    visit root_path
    fill_in "メールアドレス", with: email
    fill_in "パスワード", with: 'password'
    within ".form_outer" do
      click_on "ログイン"
    end
  end

  def logout
    visit posts_path
    click_on "ログアウト"
  end

  background do
    login("test_user_01@dic.com")
  end

  scenario "ポストの新規登録テスト" do
    click_on "新規登録"

    select "和食", from: "post_category_id"
    select "２位", from: "post_ranking_point"
    fill_in "店名", with: "和食レストラン２"
    fill_in "メニュー名", with: "チキンかあさん煮定食"
    attach_file "Image", "#{Rails.root}/spec/fixtures/default.png"
    fill_in "備考欄", with: "美味しかった！"

    click_on "登録する"

    within ".thumbnail[2]" do
      expect(page).to have_content "和食"
      expect(page).to have_content "２位"
      expect(page).to have_content "和食レストラン２"
      expect(page).to have_content "チキンかあさん煮定食"
      expect(page).to have_content "未登録"
      expect(page).to have_content "美味しかった！"
    end
  end

  scenario "ポストを編集できるかテスト" do
    visit user_path(user1)
    all("div.thumbnail")[0].click_on "編集"

    select "和食", from: "post_category_id"
    select "１位", from: "post_ranking_point"
    fill_in "店名", with: "店名を編集しました！"
    fill_in "メニュー名", with: "サバの味噌煮定食"
    attach_file "Image", "#{Rails.root}/spec/fixtures/default.png"
    fill_in "備考欄", with: "美味しかった！"

    click_on "更新する"

    within ".thumbnail" do
      expect(page).to have_content "和食"
      expect(page).to have_content "１位"
      expect(page).to have_content "店名を編集しました！"
      expect(page).to have_content "サバの味噌煮定食"
      expect(page).to have_content "未登録"
      expect(page).to have_content "美味しかった！"
    end
  end

  scenario "ポストを削除できるかテスト" do
    visit user_path(user1)
    all("div.thumbnail")[0].click_on "削除"

    expect(page).to have_content "ランキングを削除しました！"
  end

  scenario "ランキング一覧画面へ遷移できるかテスト" do
    visit user_path(user1)
    within "header" do
      click_on "ランキング一覧画面へ"
    end

    expect(page).to have_content "いいねランキング"
    expect(page).to have_content "総合ランキング"
  end

  scenario "所在地で検索できるかテスト" do
    visit posts_path
    fill_in "post_eatery_address", with: "未登録"
    click_on "検索"

    expect(page).to have_content "和食レストラン"
  end

  scenario "店名で検索できるかテスト" do
    visit posts_path
    fill_in "post[eatery_name]", with: "和食レストラン"
    click_on "検索"

    expect(page).to have_content "和食レストラン"
  end

  scenario "カテゴリーで検索できるかテスト" do
    visit posts_path
    select "和食", from: "post_category_id"
    click_on "検索"

    expect(page).to have_content "和食レストラン"
  end

  scenario "順位で検索できるかテスト" do
    visit posts_path
    select "１位", from: "post_ranking_point"
    click_on "検索"

    expect(page).to have_content "和食レストラン", "ラーメン屋"
  end

  scenario "いいねランキングでソートできるかテスト" do
    logout
    login("test_user_02@dic.com")
    Like.create!(post_id: post1.id, user_id: user2.id)# @user2.idにすると@userがnilになってしまう？

    visit posts_path
    click_on "いいねランキング"

    all(".thumbnail")[0].click_on "詳細をみる"
    expect(page).to have_content "和食レストラン"
  end

  scenario "総合ランキングでソートできるかテスト" do
    Like.create!(post_id: post1.id, user_id: user2.id)
    Post.create!(
      ranking_point: 3,
      eatery_name: "和食レストラン",
      eatery_food: "-------",
      eatery_address: "-------",
      eatery_website: "-------",
      remarks: "-------",
      likes_count: 0,
      category_id: category1.id,
      user_id: user2.id
    )

    visit posts_path
    click_on "総合ランキング"

    expect(page).to have_content "7ポイント"
  end

  scenario "総合ランキングでソートできるかテスト" do
    visit posts_path
    within "tr.active_category[1]" do
      click_link "和食"
    end

    expect(page).to have_content "和食レストラン"
  end

  scenario "マイページへ遷移できるかテスト" do
    visit user_path(user1)
    within "header" do
      click_on "マイページ"
    end
    
    expect(page).to have_content "test_user_01"
  end
end
