class AddPriceToCeramiques < ActiveRecord::Migration[5.0]
  def change
    add_monetize :ceramiques, :price, currency: { present: false }
  end
end
