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
    end

    context '新規投稿画面で所在地を入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_address) { '' }
      end

      it '未登録と保存される' do
        expect(page).to have_selector '.eadd_text', text: '未登録'
      end
    end

    context '新規投稿画面でWebsiteを入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_eatery_website) { '' }
      end

      it '未登録と保存される' do
        expect(page).to have_selector '.eweb_text', text: '未登録'
      end
    end

    context '新規投稿画面で詳しい説明を入力しなかったとき' do
      include_context '全項目を入力' do
        let(:post_remarks) { '' }
      end

      it '空文字列で保存される' do
        expect(page).to have_selector '.caption_remarks', text: ''
      end
    end
  end

  # scenario '投稿記事を編集できるかテスト' do
  #   all('div.thumbnail')[0].click_on 'EDIT'
  #
  #   select '和食', from: 'post_category_id'
  #   select '１位', from: 'post_ranking_point'
  #   fill_in 'Eatery name', with: 'Eatery nameを編集しました！'
  #   fill_in 'Menu', with: 'サバの味噌煮定食'
  #   attach_file '画像', "#{Rails.root}/spec/fixtures/default.png"
  #   fill_in '一言、好きな理由を添えて投稿をお願いします', with: '美味しかった！'
  #
  #   click_on '更新する'
  #
  #   within '.thumbnail' do
  #     expect(page).to have_content '和食'
  #     expect(page).to have_content '１位'
  #     expect(page).to have_content 'Eatery nameを編集しました！'
  #     expect(page).to have_content 'サバの味噌煮定食'
  #     expect(page).to have_content '未登録'
  #     expect(page).to have_content '美味しかった！'
  #   end
  # end
  #
  # scenario '投稿を削除できるかテスト' do
  #   all('div.thumbnail')[0].click_on 'DELETE'
  #
  #   expect(page).to have_content '投稿を削除しました'
  # end
  #
  # feature '検索、ソート機能', type: :feature do
  #   background do
  #     within 'header' do
  #       click_on 'ランキング一覧'
  #     end
  #   end
  #
  #   scenario '所在地で検索できるかテスト' do
  #     fill_in 'q_eatery_address_cont', with: '未登録'
  #     click_on 'Search!'
  #
  #     expect(page).to have_content '和食レストラン', 'ラーメン屋'
  #   end
  #
  #   scenario '店名で検索できるかテスト' do
  #     fill_in 'q_eatery_name_cont', with: '和食レストラン'
  #     click_on 'Search!'
  #
  #     expect(page).to have_content '和食レストラン'
  #   end
  #
  #   scenario 'カテゴリーで検索できるかテスト' do
  #     select '和食', from: 'q_category_id_eq'
  #     click_on 'Search!'
  #
  #     expect(page).to have_content '和食レストラン'
  #   end
  #
  #   scenario '順位で検索できるかテスト' do
  #     select '１位', from: 'q_ranking_point_eq'
  #     click_on 'Search!'
  #
  #     expect(page).to have_content '和食レストラン', 'ラーメン屋'
  #   end
  #
  #   scenario 'いいね！ランキングでソートできるかテスト' do
  #     click_on 'いいね！ランキング'
  #
  #     all('.thumbnail')[0].click_on 'Learn more!'
  #     expect(page).to have_content 'ラーメン屋'
  #   end
  #
  #   scenario '総合ランキングでソートできるかテスト' do
  #     click_on '総合ランキング'
  #
  #     expect(page).to have_content '1位 店名：和食レストラン（和食） 6ポイント'
  #   end
  #
  #   scenario 'カテゴリーでソートできるかテスト' do
  #     within 'tr.active_category[1]' do
  #       click_link '和食'
  #     end
  #
  #     expect(page).to have_content '和食レストラン'
  #   end
  # end
end
