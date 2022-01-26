class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.decimal :price_at_order
      t.references :order, null: false, foreign_key: true
      t.references :product_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
