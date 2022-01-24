class Product < ApplicationRecord
  has_one :product_detail, dependent: :destroy
  belongs_to :category

  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates
end
