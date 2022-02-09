class ProductColor < ApplicationRecord
  has_many :product_details, dependent: :destroy
  validates :color, presence: true, uniqueness: true
end
