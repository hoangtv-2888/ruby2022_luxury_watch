FactoryBot.define do
  factory :product do
    name {Faker::Lorem.sentence(word_count: 5)}
    desc {Faker::Lorem.sentence(word_count: 10)}
    category_id {FactoryBot.create(:category).id}
  end
end
