FactoryBot.define do
  factory :product do
    name {Faker::Name.first_name}
    desc {Faker::Lorem.sentence(word_count: 10)}
    category_id {FactoryBot.create(:category).id}
  end
end
