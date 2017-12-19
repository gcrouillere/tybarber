class ChangeCeramiqueDescription < ActiveRecord::Migration[5.0]
  def change
    change_column :ceramiques, :description, :text
  end
end
