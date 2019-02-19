require "rails_helper"

RSpec.feature "ユーザー管理機能", type: :feature do

  background do
    @user1 = FactoryBot.create(:user)
    # @user2 = FactoryBot.create(:second_user)
    @category1 = FactoryBot.create(:category)
    # @category2 = FactoryBot.create(:second_category)
    @post1 = FactoryBot.create(:post, category: @category1, user: @user1)
    # @post2 = FactoryBot.create(:second_post, category: @category2, user: @user2)
    # binding.pry
    @picture1 = FactoryBot.create(:picture, imageable_id: @post1.id, imageable_type: @post1.class)
    # @picture2 = FactoryBot.create(:user_picture)
  end

  scenario "ログインできるかテスト" do

    visit root_path

    fill_in "session[email]", with: "test_user_01@dic.com"
    fill_in "session[password]", with: "password"

    within ".form_outer" do
      click_on('ログイン')
    end
    # click_on "ログイン",　match: :first
    # find("#test").click
    # save_and_open_page
    expect(page).to have_content "ログインに成功しました！"
  end
end
