require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが501文字以上または空だとバリデーションが通らない' do
    user = User.new(name: '', email: 'test_user@dic.com', password: 'password')
    expect(user).not_to be_valid
    user = User.new(name: 'a' * 501, email: 'test_user@dic.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'emailが501文字以上または空だとバリデーションが通らない' do
    user = User.new(name: 'test_user', email: '', password: 'password')
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: "#{'a' * 500}@dic.com", password: 'password')
    expect(user).not_to be_valid
  end

  it 'emailの表記が正しくなかったときバリデーションが通らない' do
    user = User.new(name: 'test_user', email: ',[]./_-]^@dic.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'emailが既に存在していたらバリデーションが通らない' do
    User.create!(name: 'sample', email: 'test_user@dic.com', password: 'password')
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'passwordが6文字以下または101文字以上または空だとバリデーションが通らない' do
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: '')
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'a' * 5)
    expect(user).not_to be_valid
    user = User.new(name: 'test_user', email: 'test_user@dic.com', password: 'a' * 101)
    expect(user).not_to be_valid
  end
end
