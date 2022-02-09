class ChangeColumnReferenceToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :discount_id, true
  end
end
