class Discount < ApplicationRecord
  has_many :orders, dependent: :destroy
  scope :by_code, ->(code){where code: code if code.present?}
  scope :check_date, ->{where("? BETWEEN start AND end", Time.zone.now)}

  validates :code, uniqueness: true
end
