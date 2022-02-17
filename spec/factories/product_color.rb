FactoryBot.define do
  factory :product_color do
    color {Faker::Color.color_name}
  end
end
