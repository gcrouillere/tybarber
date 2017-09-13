class AddLessonToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :lesson, foreign_key: true
  end
end
