class AddStatusToListings < ActiveRecord::Migration
  def change
    add_column :listings, :status, :string, :default => "Pending Approval"
  end
end
