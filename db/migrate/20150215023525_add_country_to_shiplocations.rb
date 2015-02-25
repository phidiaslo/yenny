class AddCountryToShiplocations < ActiveRecord::Migration
  def change
    add_column :shiplocations, :country, :string
  end
end
