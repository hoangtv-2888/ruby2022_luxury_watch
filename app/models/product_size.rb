class ProductSize < ApplicationRecord
  has_many :product_details, dependent: :destroy
  validates :size, presence: true, uniqueness: true
end
