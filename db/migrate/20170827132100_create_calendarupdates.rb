class CreateCalendarupdates < ActiveRecord::Migration[5.0]
  def change
    create_table :calendarupdates do |t|
      t.datetime :period_start, null: false
      t.datetime :period_end, null: false
      t.timestamps
    end
  end
end
