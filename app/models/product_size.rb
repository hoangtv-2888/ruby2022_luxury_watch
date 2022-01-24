class ProductSize < ApplicationRecord
  has_many :product_details, dependent: :destroy
end
