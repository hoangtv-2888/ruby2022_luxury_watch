class AddCodeToDiscounts < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :code, :string
  end
end
