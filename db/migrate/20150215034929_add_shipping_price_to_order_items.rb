class AddShippingPriceToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :shipping_price, :decimal, default: 0.00, precision: 10, scale: 2
  end
end
