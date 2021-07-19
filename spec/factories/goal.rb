FactoryBot.define do
  factory :goal do
    goal_amount {  Faker::Commerce.price * 100 }
  end
end