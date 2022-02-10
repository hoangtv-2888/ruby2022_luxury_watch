class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.datetime :start
      t.datetime :end
      t.integer :percent
      t.timestamps
    end
  end
end
