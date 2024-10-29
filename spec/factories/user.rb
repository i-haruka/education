FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password                        {'abc1234'}
    password_confirmation           {'abc1234'}
    name { Faker::Name.name }
  end
end