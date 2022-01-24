class CreateProductColors < ActiveRecord::Migration[6.1]
  def change
    create_table :product_colors do |t|
      t.string :color
      t.string :desc

      t.timestamps
    end
  end
end
