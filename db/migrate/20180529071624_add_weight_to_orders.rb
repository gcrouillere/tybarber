class AddWeightToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :weight, :integer
  end
end
