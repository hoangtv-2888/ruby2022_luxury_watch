class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_size
  belongs_to :product_color
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  delegate :name, to: :product, prefix: :product
  delegate :size, to: :product_size
  delegate :color, to: :product_color
  validates :product_id, uniqueness:
    {scope: %i(product_size_id product_color_id)}
  validates :price, presence: true,
                    numericality: {only_integer: true,
                                   greater_than: Settings.min_val}
  validates :quantity, presence: true,
                    numericality: {only_integer: true,
                                   greater_than_or_equal_to: Settings.min_val}
end
