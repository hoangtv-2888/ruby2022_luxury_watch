class ProductColor < ApplicationRecord
  has_many :product_details, dependent: :destroy
end
