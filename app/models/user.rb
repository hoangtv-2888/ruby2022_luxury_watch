class User < ApplicationRecord
  PROPERTIES = %i(name email address phone password
                  password_confirmation remember_me).freeze
  devise :database_authenticatable, :registerable, :validatable,
         :confirmable, :recoverable, :rememberable
  has_many :orders, dependent: :destroy
  has_many :comment_rates, dependent: :destroy
  has_many :products, through: :comment_rates

  enum role: {user: Settings.user, admin: Settings.admin}

  scope :newest, ->{order created_at: :desc}
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.length_digit_255}
  validates :email, presence: true,
            length: {maximum: Settings.length_digit_255},
            format: {with: Settings.email_regex}
  validates :password, presence: true,
            length: {minimum: Settings.length_digit_6},
            allow_nil: true
  scope :search_by_name,
        ->(name){where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name}

  private
  def downcase_email
    email.downcase!
  end
end
