class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.datetime :start
      t.datetime :end
      t.integer :percent
      t.references :order, null: true, foreign_key: true

      t.timestamps
    end
  end
end
