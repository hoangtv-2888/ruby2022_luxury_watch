class CreateProductDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :product_details do |t|
      t.integer :quantity
      t.decimal :price
      t.references :product, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true
      t.references :product_color, null: false, foreign_key: true

      t.timestamps
    end
  end
end
