class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount, optional: true
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  scope :newest, ->{order created_at: :desc}
  enum status: {
    wait: 0,
    confirmed: 1,
    shipping: 2,
    delivered: 3,
    rejected: 4,
    returned: 5
  }
end
