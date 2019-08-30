require 'rails_helper'
# save_and_open_page
RSpec.describe '投稿管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = create(:user, name: 'ユーザーA', email: 'a@example.com')
      category_washoku = create(:category, name: '和食')
      create(
        :post,
        ranking_point: 'first_place',
        eatery_name: '和食レストラン',
        eatery_food: 'サバの味噌煮定食',
        remarks: '味噌に拘っている',
        category: category_washoku,
        user: user_a
      )
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end

      it 'ユーザーAが作成した投稿が表示される' do
        visit posts_path
        expect(find('.link_to_detail').hover).to have_content '和食レストラン', 'サバの味噌煮定食'
      end
    end
  end
  #
  # scenario '新規投稿テスト' do
  #   click_on 'New post'
  #
  #   select '和食', from: 'post_category_id'
  #   select '２位', from: 'post_ranking_point'
  #   fill_in 'Eatery name', with: '和食レストラン２'
  #   fill_in 'Menu', with: 'チキンかあさん煮定食'
  #   attach_file '画像', "#{Rails.root}/spec/fixtures/default.png"
  #   fill_in '一言、好きな理由を添えて投稿をお願いします', with: '美味しかった！'
  #
  #   click_on '登録する'
  #
  #   within '.thumbnail' do
  #     expect(page).to have_content '和食'
  #     expect(page).to have_content '２位'
  #     expect(page).to have_content '和食レストラン２'
  #     expect(page).to have_content 'チキンかあさん煮定食'
  #     expect(page).to have_content '未登録'
  #     expect(page).to have_content '美味しかった！'
  #   end
  # end
  #
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
