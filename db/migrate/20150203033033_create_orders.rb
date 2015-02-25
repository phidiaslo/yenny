class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :subtotal,  default: 0.00, precision: 10, scale: 2
      t.decimal :tax, default: 0.00, precision: 10, scale: 2
      t.decimal :shipping,  default: 0.00, precision: 10, scale: 2
      t.decimal :total,  default: 0.00, precision: 10, scale: 2
      t.references :order_status, index: true

      t.timestamps
    end
  end
end
