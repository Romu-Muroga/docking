require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  it 'hashnameが100文字以上または空だとバリデーションが通らない' do
    hashtag = Hashtag.new(hashname: 'a' * 100)
    expect(hashtag).not_to be_valid
    hashtag = Hashtag.new(hashname: '')
    expect(hashtag).not_to be_valid
  end
end
