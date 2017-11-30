class AddPortToOrder < ActiveRecord::Migration[5.0]
  def change
    add_monetize :orders, :port, currency: { present: false }
  end
end
