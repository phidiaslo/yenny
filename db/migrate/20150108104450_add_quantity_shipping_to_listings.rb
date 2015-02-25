class AddQuantityShippingToListings < ActiveRecord::Migration
  def change
    add_column :listings, :quantity, :integer
    add_column :listings, :processing_time, :string
  end
end
