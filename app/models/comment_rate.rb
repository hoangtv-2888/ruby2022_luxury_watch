class CommentRate < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true,
            length: {maximum: Settings.max_comment_length}
  validates :star, numericality:
    {less_than_or_equal_to: Settings.max_star,
     greater_than_or_equal_to: Settings.min_star,
     only_integer: true}
  scope :newest, ->{order created_at: :desc}
end
