FactoryBot.define do
  factory :payment do
    email { "MyString" }
    token { "MyString" }
    user { create(:user) }
  end
end
