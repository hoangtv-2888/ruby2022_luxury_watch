class Product < ApplicationRecord
  has_many :product_detail, dependent: :destroy
  belongs_to :category
  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates

  scope :newest, ->{order created_at: :desc}
end
