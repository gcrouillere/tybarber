class CreateCeramiques < ActiveRecord::Migration[5.0]
  def change
    create_table :ceramiques do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :stock, null: false
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
