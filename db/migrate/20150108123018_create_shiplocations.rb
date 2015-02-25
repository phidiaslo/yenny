class CreateShiplocations < ActiveRecord::Migration
  def change
    create_table :shiplocations do |t|
      t.integer :listing_id

      t.timestamps
    end
  end
end
