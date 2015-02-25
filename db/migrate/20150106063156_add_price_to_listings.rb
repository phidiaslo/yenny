class AddPriceToListings < ActiveRecord::Migration
  def change
    add_column :listings, :price, :decimal, precision: 10, scale: 2
  end
end
