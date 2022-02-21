FactoryBot.define do
  factory :order_detail do
    quantity{Faker::Number.non_zero_digit}
    price_at_order{Faker::Number.decimal(l_digits: 6)}
    product_detail_id{FactoryBot.create(:product_detail).id}
    order_id{FactoryBot.create(:order).id}
  end
end
