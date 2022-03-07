class OrderDetail < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :product_detail

  validates :quantity, presence: true
  validates :price_at_order, presence: true

  after_save :update_quantiy_product

  scope :by_order_status, (lambda do |status|
    joins(:order).where(order: {status: [status]})
  end)

  private
  def update_quantiy_product
    if order.wait?
      product_detail.quantity = product_detail.quantity - quantity
    elsif order.rejected?
      product_detail.quantity = product_detail.quantity + quantity
    end
    product_detail.save
  end
end
