class AddTakeawayToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :take_away, :boolean, null: false
  end
end
