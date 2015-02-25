class AddPriceToShiplocations < ActiveRecord::Migration
  def change
    add_column :shiplocations, :price, :decimal, default: 0.00, precision: 10, scale: 2, null: false
  end
end
