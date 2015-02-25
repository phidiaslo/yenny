class AddChoiceToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :choice, :string
  end
end
