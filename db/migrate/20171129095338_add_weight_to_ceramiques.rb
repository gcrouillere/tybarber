class AddWeightToCeramiques < ActiveRecord::Migration[5.0]
  def change
    add_column :ceramiques, :weight, :integer
  end
end
