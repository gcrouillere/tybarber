class CreateBasketlines < ActiveRecord::Migration[5.0]
  def change
    create_table :basketlines do |t|
      t.references :ceramique, foreign_key: true
      t.integer :quantity
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
