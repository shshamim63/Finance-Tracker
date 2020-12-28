FactoryBot.define do
  factory :user do
    first_name { 'Pepe' }
    last_name { 'Bas' }
    username { 'PepeBas' }
    email { Faker::Internet.email }
    plan { create(:plan) }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
