class CreateTopCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :top_categories do |t|
      t.string :name
      t.string :mobile_name

      t.timestamps
    end

    add_reference :categories, :top_category, foreign_key: true
  end
end
