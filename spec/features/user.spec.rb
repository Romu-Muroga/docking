require 'rails_helper'
# save_and_open_page

RSpec.feature 'ユーザー機能', type: :feature do
  background do
    user1 = FactoryBot.create(:user)
    category1 = FactoryBot.create(:category)
    post1 = FactoryBot.create(:post, category: category1, user: user1)
    FactoryBot.create(:picture, imageable_id: post1.id, imageable_type: post1.class)
  end

  scenario 'ログインできるかテスト' do
    visit root_path
    within '.start_button' do
      click_on 'Login'
    end
    fill_in 'メールアドレス', with: 'test_user_01@dic.com'
    fill_in 'パスワード', with: 'password'
    within '.form_outer' do
      click_on 'ログイン'
    end

    expect(page).to have_content 'ログインしました'
  end

  scenario 'アカウント登録ができるかテスト' do
    visit root_path
    within '.start_button' do
      click_on 'Sign up'
    end
    fill_in '名前', with: 'new_user'
    fill_in 'メールアドレス', with: 'new_user@dic.com'
    fill_in 'パスワード', with: 'password'
    fill_in '確認用パスワード', with: 'password'
    attach_file 'アイコン画像を選択してください', "#{Rails.root}/spec/fixtures/default.png"
    click_on '登録する'

    expect(page).to have_content 'new_userさんのアカウント登録とログインが完了しました'
  end

  feature 'ログインした状況', type: :feature do
    background do
      visit root_path
      within '.start_button' do
        click_on 'Login'
      end
      fill_in 'メールアドレス', with: 'test_user_01@dic.com'
      fill_in 'パスワード', with: 'password'
      within '.form_outer' do
        click_on 'ログイン'
      end
    end

    scenario 'アカウント情報を編集できるかテスト' do
      click_on 'Edit account info'
      fill_in '名前', with: '名前を編集しました！'
      fill_in 'メールアドレス', with: 'test_user_01@dic.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      attach_file 'アイコン画像を選択してください', "#{Rails.root}/spec/fixtures/default.png"
      click_on '更新する'

      expect(page).to have_content '名前を編集しました！'
    end

    scenario 'ログアウトできるかテスト' do
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end

    scenario 'アカウント削除ができるかテスト' do
      click_on 'Close the account'
      check 'チェックを入れて退会ボタンを押してください'
      click_on '退会する'

      expect(page).to have_content 'test_user_01さんのアカウントを削除しました。ご利用いただき、ありがとうございました！'
    end
  end
end
