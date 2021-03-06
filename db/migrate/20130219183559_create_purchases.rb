class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.decimal :total, :precision => 10, :scale => 2, default: 0
      t.integer :market_id
      t.date :purchase_date

      t.timestamps
    end
  end
end
