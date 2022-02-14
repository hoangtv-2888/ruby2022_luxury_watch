Category.create(name: "Casio")
Category.create(name: "Philippe")
Category.create(name: "Heuer")
Category.create(name: "Rolex")
Category.create(name: "Omega")

Category.all.pluck(:name, :id).each do |name, id|
  10.times do |n|
    product = Product.create!(name: "#{name} #{n+1}",
                  desc: Faker::Lorem.sentence(word_count: 15),
                  type: "",
                  material: Faker::Construction.material,
                  category_id: id)
    product.images.attach(io: File.open("app/assets/images/p-#{rand(1..8)}.png"), filename: 'watch', content_type: %w[image/jpeg image/gif image/png image/jpg])
    product.images.attach(io: File.open("app/assets/images/p-#{rand(1..8)}.png"), filename: 'watch', content_type: %w[image/jpeg image/gif image/png image/jpg])
    product.images.attach(io: File.open("app/assets/images/p-#{rand(1..8)}.png"), filename: 'watch', content_type: %w[image/jpeg image/gif image/png image/jpg])
    product.images.attach(io: File.open("app/assets/images/p-#{rand(1..8)}.png"), filename: 'watch', content_type: %w[image/jpeg image/gif image/png image/jpg])
  end
end

ProductSize.create(size: "38", desc: "")
ProductSize.create(size: "40", desc: "")
ProductSize.create(size: "42", desc: "")

ProductColor.create(color: "White", desc: "")
ProductColor.create(color: "Black", desc: "")
ProductColor.create(color: "Red", desc: "")
ProductColor.create(color: "Green", desc: "")

price = [1000000, 2000000, 3000000, 4000000]
Product.all.each do |product|
  5.times do |n|
    ProductDetail.create(quantity: rand(50..100),
      price: price[rand(3)] + n*50000,
      product_id: product.id,
      product_size_id: ProductSize.pluck(:id).sample,
      product_color_id: ProductColor.pluck(:id).sample)
  end
end

User.create!(name: "Example User",
            address: "quang nam",
            phone: "0239583958",
            email: "admin@gmail.com",
            password: "123456",
            password_confirmation: "123456",
            role: 1,
            activated: true,
            activated_at: Time.zone.now)

50.times do |n|
  name = Faker::Name.name
  email = "sss-#{n+1}@railstutorial.org"
  password = "password"
  address = "quang nam"
  phone = "023859835"
  User.create!(name: name,
              address: address,
              phone: phone,
              email: email,
              password: password,
              password_confirmation: password,
              role: 0,
              activated: true,
              activated_at: Time.zone.now)
end

50.times do
  CommentRate.create(content: Faker::Lorem.sentence(word_count: 20),
                     star: rand(3..5),
                     user_id: User.pluck(:id).sample,
                     product_id: Product.pluck(:id).sample)
end

Discount.create!(
  start: Time.zone.now,
  end: Time.now + 10.days,
  percent: 5,
  code: "aaaaa"
)

Discount.create!(
  start: Time.zone.now,
  end: Time.now + 10.days,
  percent: 0,
  code: "00000"
)
20.times do
  order = Order.create!(status: rand(0..4),
                       user_id: User.pluck(:id).sample,
                       user_name_at_order: Faker::Name.name,
                       address_at_order: "quang nam",
                       discount_id: Discount.pluck(:id).sample)
  3.times do |n|
    prdt = ProductDetail.select(:id, :price).sample
    odt = order.order_details.create(quantity: n+1,
                                    price_at_order: prdt.price,
                                    order_id: order.id,
                                    product_detail_id: prdt.id)

  end
end
