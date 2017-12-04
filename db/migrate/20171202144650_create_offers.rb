class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.boolean :showcased, null: false, default: false
      t.float :discount


      t.timestamps
    end
  end
end
