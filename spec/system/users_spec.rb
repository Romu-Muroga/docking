require 'rails_helper'
# save_and_open_page
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'マイページ表示機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAのマイページが表示される' do
        expect(page).to have_content 'ユーザーA'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }
      
      it 'ユーザーAのマイページは表示されない' do
        expect(page).to have_no_content 'ユーザーA'
      end
    end
  end
end
