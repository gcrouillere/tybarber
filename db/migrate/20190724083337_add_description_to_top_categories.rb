class AddDescriptionToTopCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :top_categories, :description, :text
  end
end
