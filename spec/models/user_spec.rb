require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが501文字以上または空だとバリデーションが通らない' do
    user = User.new(name: '', email: 'test_user@dic.com', password: 'password', admin: false)
    expect(user).not_to be_valid
    user = User.new(name: 'a' * 501, email: 'test_user@dic.com', password: 'password', admin: false)
    expect(user).not_to be_valid
  end

  it 'emailが501文字以上または空だとバリデーションが通らない' do
    user = User.new(name: 'test_user', email: '', password: 'password', admin: false)
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: "#{'a' * 500}@dic.com", password: 'password', admin: false)
    expect(user).not_to be_valid
  end

  it 'emailの表記が正しくなかったときバリデーションが通らない' do
    user = User.new(name: 'test_user', email: '不正な値@dic.com', password: 'password', admin: false)
    expect(user).not_to be_valid
  end

  it 'emailが既に存在していたらバリデーションが通らない' do
    User.create!(name: 'sample', email: 'test_user@dic.com', password: 'password', admin: false)
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'password', admin: false)
    expect(user).not_to be_valid
  end

  it 'passwordが6文字以下または101文字以上または空だとバリデーションが通らない' do
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: '', admin: false)
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'a' * 5, admin: false)
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'a' * 101, admin: false)
    expect(user).not_to be_valid
  end

  it 'adminがtrueまたはfalse以外だとバリデーションが通らない' do
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'password', admin: nil)
    expect(user).not_to be_valid
  end
end
