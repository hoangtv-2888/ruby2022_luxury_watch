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
  validates :user_name_at_order, presence: true
  validates :address_at_order, presence: true
  scope :search_id,
        ->(id){where("id = ?", id) if id}
  scope :by_status,
        ->(type){where("status = ?", type) if type}

  def status_buy_again?
    delivered? || returned? || rejected?
  end

  scope :newest, ->{order created_at: :desc}
  scope :search, (lambda do |str|
    if str
      joins(:user)
      .where(user: {name: str})
      .or(search_by_id(str))
    end
  end)
  scope :search_by_id, (lambda do |str|
    if str
      joins(:user)
      .where(id: str)
    end
  end)
end
