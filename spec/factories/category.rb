FactoryBot.define do
  factory :category do
    name {Faker::Lorem.sentence(word_count: 5)}
  end
end
