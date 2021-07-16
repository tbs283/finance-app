FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.characters(number:10) }
    content { Faker::Lorem.characters(number:100) }
  end
end