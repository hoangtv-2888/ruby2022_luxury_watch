class ChangeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:orders, :status, nil)
  end
end
