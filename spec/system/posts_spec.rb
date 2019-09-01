require 'rails_helper'
# save_and_open_page
RSpec.describe '投稿管理機能', type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let(:category_washoku) { create(:category, name: '和食') }
  let(:category_ramen) { create(:category, name: 'ラーメン') }
  let!(:post_a) do
    create(:post,
           ranking_point: 'first_place',
           eatery_name: '和食レストラン',
           eatery_food: 'サバの味噌煮定食',
           category: category_washoku,
           user: user_a)
  end
  let!(:post_b) do
    create(:post,
           ranking_point: 'first_place',
           eatery_name: 'ラーメン屋',
           eatery_food: '醤油ラーメン',
           category: category_ramen,
           user: user_b)
  end

  shared_context '全項目を入力' do
    let(:post_category) { '和食' }
    let(:post_ranking) { '２位' }
    let(:post_eatery_name) { '和食レストラン' }
    let(:post_eatery_food) { 'サバの味噌煮定食' }
    let(:post_eatery_address) { '東京都渋谷区' }
    let(:post_eatery_website) { 'https://example.com' }
    let(:post_remarks) { '美味しかった' }
  end

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  describe '一覧表示機能' do
    let(:login_user) { user_a }

    it '投稿一覧が表示される' do
      visit posts_path
      expect(page.all('.link_to_detail')[0].hover).to have_content 'ラーメン', '醤油ラーメン'
      expect(page.all('.link_to_detail')[1].hover).to have_content '和食レストラン', 'サバの味噌煮定食'
    end
  end

  describe '詳細表示機能' do
    let(:login_user) { user_a }

    before do
      visit post_path(post_a)
    end

    it '投稿記事の詳細が表示される' do
      expect(page).to have_content '和食レストラン', 'サバの味噌煮定食'
    end
  end

  describe '新規投稿機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      select post_category, from: 'カテゴリー'
      select post_ranking, from: '順位'
      fill_in '店名', with: post_eatery_name
      fill_in 'メニュー', with: post_eatery_food
      fill_in '所在地（任意）', with: post_eatery_address
      fill_in 'Website（任意）', with: post_eatery_website
      attach_file '画像（任意）', "#{Rails.root}/spec/fixtures/default.png"
      fill_in '詳しい説明', with: post_remarks
      click_button '登録する'
    end

    context '新規投稿画面で全項目を入力したとき' do
      include_context '全項目を入力'

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '和食レストラン'
      end
    end

    context '新規投稿画面で店名を入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_name) { '' }
      end

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '店名を入力してください'
        end
      end

      context '店名を200文字以上入力したとき' do
        include_context '全項目を入力' do
          let(:post_eatery_name) { 'a' * 201 }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '店名は200文字以内で入力してください'
          end
        end
      end
    end

    context '新規投稿画面でメニューを入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_food) { '' }
      end

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'メニューを入力してください'
        end
      end

      context 'メニューを200文字以上入力したとき' do
        include_context '全項目を入力' do
          let(:post_eatery_food) { 'a' * 201 }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'メニューは200文字以内で入力してください'
          end
        end
      end
    end

    context '新規投稿画面で所在地を入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_address) { '' }
      end

      it '未登録と保存される' do
        expect(page).to have_selector '.eadd_text', text: '未登録'
      end

      context '所在地を500文字以上入力したとき' do
        include_context '全項目を入力' do
          let(:post_eatery_address) { 'a' * 501 }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '所在地は500文字以内で入力してください'
          end
        end
      end
    end

    context '新規投稿画面でWebsiteを入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_website) { '' }
      end

      it '未登録と保存される' do
        expect(page).to have_selector '.eweb_text', text: '未登録'
      end

      context 'Websiteを500文字以上入力したとき' do
        include_context '全項目を入力' do
          let(:post_eatery_website) { 'a' * 501 }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'Websiteは500文字以内で入力してください'
          end
        end
      end

      context 'WebsiteのURLを不正な値で入力したとき' do
        include_context '全項目を入力' do
          let(:post_eatery_website) { 'xxxxx://example.com' }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'Websiteは不正な値です'
          end
        end
      end
    end

    context '新規投稿画面で詳しい説明を入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_remarks) { '' }
      end

      it '空文字列で保存される' do
        expect(page).to have_selector '.caption_remarks', text: ''
      end

      context '詳しい説明を2000文字以上入力したとき' do
        include_context '全項目を入力' do
          let(:post_remarks) { 'a' * 2001 }
        end

        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '詳しい説明は2000文字以内で入力してください'
          end
        end
      end
    end

    context '新規投稿画面で登録済みのカテゴリーと順位の組み合わせで入力をしたとき' do
      include_context '全項目を入力' do
        let(:post_ranking) { '１位' }
      end

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '順位はすでに存在します'
        end
      end
    end
  end
end
