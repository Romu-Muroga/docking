require 'rails_helper'
# save_and_open_page

RSpec.feature '投稿機能', type: :feature do
  def login(email)
    visit root_path
    within '.start_button' do
      click_on 'Login'
    end
    fill_in 'メールアドレス', with: email
    fill_in 'パスワード', with: 'password'
    within '.form_outer' do
      click_on 'ログイン'
    end
  end

  def logout
    click_on 'ログアウト'
  end

  background do
    # user
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:second_user)
    # category
    category1 = FactoryBot.create(:category)
    category2 = FactoryBot.create(:second_category)
    # post
    post1 = FactoryBot.create(:post, category: category1, user: user1)
    post2 = FactoryBot.create(:second_post, category: category2, user: user1)
    post3 = FactoryBot.create(:post, category: category1, user: user2)
    # picture
    FactoryBot.create(:picture, imageable_id: post1.id, imageable_type: post1.class)
    FactoryBot.create(:picture, imageable_id: post2.id, imageable_type: post2.class)
    FactoryBot.create(:picture, imageable_id: post3.id, imageable_type: post3.class)
    # iine
    FactoryBot.create(:like, post: post2, user: user2)
    # login
    login('test_user_01@dic.com')
  end

  scenario '新規投稿テスト' do
    click_on 'New post'

    select '和食', from: 'post_category_id'
    select '２位', from: 'post_ranking_point'
    fill_in 'Eatery name', with: '和食レストラン２'
    fill_in 'Menu', with: 'チキンかあさん煮定食'
    attach_file '画像', "#{Rails.root}/spec/fixtures/default.png"
    fill_in '一言、好きな理由を添えて投稿をお願いします', with: '美味しかった！'

    click_on '登録する'

    within '.thumbnail' do
      expect(page).to have_content '和食'
      expect(page).to have_content '２位'
      expect(page).to have_content '和食レストラン２'
      expect(page).to have_content 'チキンかあさん煮定食'
      expect(page).to have_content '未登録'
      expect(page).to have_content '美味しかった！'
    end
  end

  scenario '投稿記事を編集できるかテスト' do
    all('div.thumbnail')[0].click_on 'EDIT'

    select '和食', from: 'post_category_id'
    select '１位', from: 'post_ranking_point'
    fill_in 'Eatery name', with: 'Eatery nameを編集しました！'
    fill_in 'Menu', with: 'サバの味噌煮定食'
    attach_file '画像', "#{Rails.root}/spec/fixtures/default.png"
    fill_in '一言、好きな理由を添えて投稿をお願いします', with: '美味しかった！'

    click_on '更新する'

    within '.thumbnail' do
      expect(page).to have_content '和食'
      expect(page).to have_content '１位'
      expect(page).to have_content 'Eatery nameを編集しました！'
      expect(page).to have_content 'サバの味噌煮定食'
      expect(page).to have_content '未登録'
      expect(page).to have_content '美味しかった！'
    end
  end

  scenario '投稿を削除できるかテスト' do
    all('div.thumbnail')[0].click_on 'DELETE'

    expect(page).to have_content '投稿を削除しました'
  end

  scenario 'ランキング一覧ページへ遷移できるかテスト' do
    within 'header' do
      click_on 'ランキング一覧'
    end

    expect(page).to have_content '総合ランキング'
    expect(page).to have_content 'いいね！ランキング'
  end

  scenario '所在地で検索できるかテスト' do
    visit posts_path
    fill_in 'q_eatery_address_cont', with: '未登録'
    click_on 'Search!'

    expect(page).to have_content '和食レストラン', 'ラーメン屋'
  end

  scenario '店名で検索できるかテスト' do
    visit posts_path
    fill_in 'q_eatery_name_cont', with: '和食レストラン'
    click_on 'Search!'

    expect(page).to have_content '和食レストラン'
  end

  scenario 'カテゴリーで検索できるかテスト' do
    visit posts_path
    select '和食', from: 'q_category_id_eq'
    click_on 'Search!'

    expect(page).to have_content '和食レストラン'
  end

  scenario '順位で検索できるかテスト' do
    visit posts_path
    select '１位', from: 'q_ranking_point_eq'
    click_on 'Search!'

    expect(page).to have_content '和食レストラン', 'ラーメン屋'
  end

  scenario 'いいね！ランキングでソートできるかテスト' do
    visit posts_path
    click_on 'いいね！ランキング'

    all('.thumbnail')[0].click_on 'Learn more!'
    expect(page).to have_content 'ラーメン屋'
  end

  scenario '総合ランキングでソートできるかテスト' do
    visit posts_path
    click_on '総合ランキング'

    expect(page).to have_content '1位 店名：和食レストラン（和食） 6ポイント'
  end

  scenario 'カテゴリーでソートできるかテスト' do
    visit posts_path
    within 'tr.active_category[1]' do
      click_link '和食'
    end

    expect(page).to have_content '和食レストラン'
  end

  scenario '私のお気に入りへ遷移できるかテスト' do
    visit posts_path
    within 'header' do
      click_on '私のお気に入り'
    end

    expect(page).to have_content 'test_user_01'
  end
end
