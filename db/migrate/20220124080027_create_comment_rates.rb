class CreateCommentRates < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_rates do |t|
      t.string :content
      t.integer :star
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
