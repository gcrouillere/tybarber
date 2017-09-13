class AddQuantityToBasketLines < ActiveRecord::Migration[5.0]
  def change
    add_column :basketlines, :quantity, :integer
  end
end
