FactoryBot.define do
  factory :user do
    name{Faker::Name.name_with_middle}
    email{Faker::Internet.email.downcase}
    phone{Faker::PhoneNumber.cell_phone}
    address{Faker::Address.full_address}
    password{"tuong123"}
    password_confirmation{"tuong123"}
    confirmed_at{Date.today}
  end
end
