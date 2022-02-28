class Order < ApplicationRecord
  belongs_to :user
  belongs_to :discount, optional: true
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  enum status: {
    wait: 0,
    confirmed: 1,
    shipping: 2,
    delivered: 3,
    rejected: 4,
    returned: 5
  }
  delegate :name, :email, to: :user, prefix: :user
  validates :user_name_at_order, presence: true
  validates :address_at_order, presence: true
  scope :by_status,
        ->(type){where("status = ?", type) if type}

  def status_buy_again?
    delivered? || returned? || rejected?
  end

  scope :newest, ->{order created_at: :desc}
end
