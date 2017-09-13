class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :day, null: false
      t.integer :capacity, null: false
      t.boolean :full, null: false, default: false
      t.timestamps
    end
  end
end
