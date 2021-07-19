FactoryBot.define do
  factory :balance do
    amount { Faker::Commerce.price * 100 }
    description { Faker::Lorem.characters(number:10) }
  end
end