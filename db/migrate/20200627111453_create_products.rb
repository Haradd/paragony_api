class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.decimal :price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.integer :quantity
      t.references :receipt, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
