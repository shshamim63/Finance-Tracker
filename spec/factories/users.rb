FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    username { Faker::Name.unique.name }
    email { Faker::Internet.email }
    plan { create(:plan) }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
