class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates
end
