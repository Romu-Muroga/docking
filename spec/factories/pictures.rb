FactoryBot.define do

  factory :picture do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/default.png')) }
    imageable_id {}
    imageable_type {}
  end

  factory :second_picture, class: Picture do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/default.png')) }
    imageable_id {}
    imageable_type {}
  end
end
