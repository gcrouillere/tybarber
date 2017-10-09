class AddSlugToCeramique < ActiveRecord::Migration[5.0]
  def change
    add_column :ceramiques, :slug, :string, unique: true
  end
end
