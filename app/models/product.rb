class Product < ApplicationRecord
  has_many :product_detail, dependent: :destroy
  belongs_to :category
  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates
  has_many_attached :images
  accepts_nested_attributes_for :product_detail,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :desc, presence: true,
            length: {maximum: Settings.max_comment_length}
  validates :images,
            content_type:
            {
              in: Settings.image_format,
              message: I18n.t("invalid_format")
            },
            size:
            {
              less_than: Settings.image_size.megabytes,
              message: I18n.t("invalid_size")
            }
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

  def display_image image
    image.variant(resize: Settings.resize_images).processed
  end
end
