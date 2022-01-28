5.times do
  Category.create(name:Faker::Nation.language)
end

30.times do
  Product.create(name: Faker::Nation.capital_city,
                 desc: Faker::Lorem.sentence(word_count: 3),
                 type: "",
                 material: Faker::Construction.material,
                 category_id: Category.pluck(:id).sample)
end

sizes = [32, 33, 35, 38]

4.times do
  ProductSize.create(size: sizes[rand(0..3)],
                     desc: "")
end

4.times do
  ProductColor.create(color: Faker::Color.color_name,
                      desc: "")
end

100.times do |n|
  ProductDetail.create(quantity: n,
                       price: n*1000000,
                       product_id: Product.pluck(:id).sample,
                       product_size_id: ProductSize.pluck(:id).sample,
                       product_color_id: ProductColor.pluck(:id).sample)
  end
