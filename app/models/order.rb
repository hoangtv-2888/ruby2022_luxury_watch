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
  validates :user_name_at_order, presence: true
  validates :address_at_order, presence: true
  scope :search_id,
        ->(id){where("id = ?", id) if id}
end
