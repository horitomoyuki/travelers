FactoryBot.define do
  factory :talk do
    content {Faker::Lorem.sentence}
    association :user
    association :room
  end

  after(:build) do |talk|
    talk.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  end
end