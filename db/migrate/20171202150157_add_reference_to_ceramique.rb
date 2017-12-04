class AddReferenceToCeramique < ActiveRecord::Migration[5.0]
  def change
    add_reference :ceramiques, :offer, foreign_key: true
  end
end
