class AddStockToVariations < ActiveRecord::Migration
  def change
    add_column :variations, :stock, :integer, :default => 0, :null => false
  end
end
