FactoryBot.define do
  factory :order do
    status{3}
    user_name_at_order{Faker::Name.name_with_middle}
    address_at_order{Faker::Address.street_address}
  end
end
