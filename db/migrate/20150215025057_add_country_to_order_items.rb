class AddCountryToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :country, :string
  end
end
