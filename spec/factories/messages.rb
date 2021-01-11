FactoryBot.define do
  factory :message do
    body { "MyText" }
    user { create(:user) }
  end
end
