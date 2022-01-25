class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_size
  belongs_to :product_color
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
end
