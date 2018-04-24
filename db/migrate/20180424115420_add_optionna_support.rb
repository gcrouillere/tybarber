class AddOptionnaSupport < ActiveRecord::Migration[5.0]
  def change
    add_monetize :ceramiques, :support_price, currency: { present: false }
    add_column :basketlines, :with_support, :boolean
  end
end
