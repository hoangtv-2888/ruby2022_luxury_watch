class CreateProductSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_sizes do |t|
      t.integer :size
      t.string :desc

      t.timestamps
    end
  end
end
