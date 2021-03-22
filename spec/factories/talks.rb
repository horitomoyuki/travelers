FactoryBot.define do
  factory :talk do
    content {Faker::Lorem.sentence}
    association :user
    association :room
  end
end