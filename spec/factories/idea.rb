FactoryBot.define do
  factory :idea do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:30) }
    user { association :user }
  end
end