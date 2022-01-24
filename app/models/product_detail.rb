class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_size
  belongs_to :product_color
end
