require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'nameが501文字以上または空だとバリデーションが通らない' do
    category = Category.new(name: 'a' * 501)
    expect(category).not_to be_valid
    category = Category.new(name: '')
    expect(category).not_to be_valid
  end
end
