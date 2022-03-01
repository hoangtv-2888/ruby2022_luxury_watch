class OrderDetail < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :product_detail

  validates :quantity, presence: true
  validates :price_at_order, presence: true

  scope :by_order_status, (lambda do |status|
    joins(:order).where(order: {status: [status]})
  end)
end
