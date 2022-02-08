class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  validates :name, presence: true, uniqueness: true,
    length: {maximum: Settings.max_name_length}
end
