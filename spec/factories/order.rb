FactoryBot.define do
  factory :order do
    status{0}
    user_name_at_order{Faker::Name.first_name}
    address_at_order{Faker::Name.first_name}
    user_id{FactoryBot.create(:user).id}
  end
end
