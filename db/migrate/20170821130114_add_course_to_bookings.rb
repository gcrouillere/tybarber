class AddCourseToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :course, :integer
  end
end
