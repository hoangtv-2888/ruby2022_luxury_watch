class CreateProductSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_sizes do |t|
      t.string :size
      t.string :integer
      t.string :desc

      t.timestamps
    end
  end
end
