class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product_detail

  validates :quantity, presence: true
  validates :price_at_order, presence: true
end
