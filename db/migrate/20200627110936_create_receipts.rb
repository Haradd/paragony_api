class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.decimal :total_price, precision: 10, scale: 2
      t.date :date
      t.string :shop_details
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
