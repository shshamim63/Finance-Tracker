FactoryBot.define do
  factory :stock do
    ticker { "MyString" }
    name { "mystring" }
    last_price { 9.99 }
  end
end
