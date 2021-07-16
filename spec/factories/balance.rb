FactoryBot.define do
  factory :balance do
    amount {100000}
    description { Faker::Lorem.characters(number:10) }
  end
end