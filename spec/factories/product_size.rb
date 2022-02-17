FactoryBot.define do
  factory :product_size do
    size {Faker::Number.between(from: 38, to: 40)}
  end
end
