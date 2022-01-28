class Product < ApplicationRecord
  has_many :product_detail, dependent: :destroy
  belongs_to :category
  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates

  scope :newest, ->{order created_at: :desc}
  scope :search_by_name,
        ->(name){where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name}
  scope :filter_by_category_id,
        ->(category_id){joins(:category).where(category: category_id)}
  scope :filter_by_product_size_id, (lambda do |product_size_id|
    joins(:product_detail)
    .where(product_detail: {product_size_id: product_size_id})
  end)
  scope :filter_by_product_color_id, (lambda do |product_color_id|
    joins(:product_detail)
    .where(product_detail: {product_color_id: product_color_id})
  end)
end
