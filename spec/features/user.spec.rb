require "rails_helper"

RSpec.feature "ユーザー機能", type: :feature do
  # save_and_open_page
  background do
    @user1 = FactoryBot.create(:user)
    category1 = FactoryBot.create(:category)
    post1 = FactoryBot.create(:post, category: category1, user: @user1)
    FactoryBot.create(:picture, imageable_id: post1.id, imageable_type: post1.class)
  end

  scenario "ログインできるかテスト" do
    visit root_path
    within "header .nav" do
      click_on "ログイン"
    end

    fill_in "メールアドレス", with: "test_user_01@dic.com"
    fill_in "パスワード", with: "password"

    within ".form_outer" do
      click_on "ログイン"
    end
    # click_on "ログイン",　match: :first
    # find("#test").click

    expect(page).to have_content "ログインに成功しました！"
  end

  scenario "アカウント登録ができるかテスト" do
    visit new_user_path

    fill_in "名前", with: "new_user"
    fill_in "メールアドレス", with: "new_user@dic.com"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"
    attach_file "アイコン画像を選択してください", "#{Rails.root}/spec/fixtures/default.png"

    click_on "登録する"
    expect(page).to have_content "アカウント登録＋ログインに成功しました！"
  end

  feature "ログインした状況", type: :feature do

    background do
      visit root_path
      fill_in "メールアドレス", with: "test_user_01@dic.com"
      fill_in "パスワード", with: "password"
      within ".form_outer" do
        click_on "ログイン"
      end
    end

    scenario "アカウント情報を編集できるかテスト" do
      visit edit_user_path(@user1.id)
      save_and_open_page
      fill_in "名前", with: "名前の編集しました！"
      fill_in "メールアドレス", with: "test_user_01@dic.com"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      attach_file "アイコン画像を選択してください", "#{Rails.root}/spec/fixtures/default.png"

      click_on "更新する"
      expect(page).to have_content "アカウント情報を更新しました！"
    end

    scenario "ログアウトできるかテスト" do
      visit posts_path
      click_on "ログアウト"

      expect(page).to have_content "ログアウトしました！"
    end
  end
end
