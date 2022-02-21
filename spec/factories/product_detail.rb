FactoryBot.define do
  factory :product_detail do
    product_id {FactoryBot.create(:product).id}
    product_size_id {FactoryBot.create(:product_size).id}
    product_color_id {FactoryBot.create(:product_color).id}
    price {Faker::Number.number(digits: 6)}
    quantity {Faker::Number.number(digits: 3)}
  end
end
