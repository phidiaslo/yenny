class AddShippingCostToShiplocations < ActiveRecord::Migration
  def change
    add_column :shiplocations, :cost, :decimal, default: 0.00, precision: 10, scale: 2
  end
end
