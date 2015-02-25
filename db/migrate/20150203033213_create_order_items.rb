class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :listing, index: true
      t.references :order, index: true
      t.decimal :unit_price, default: 0.00, precision: 10, scale: 2
      t.integer :quantity
      t.decimal :total_price, default: 0.00, precision: 10, scale: 2

      t.timestamps
    end
  end
end
