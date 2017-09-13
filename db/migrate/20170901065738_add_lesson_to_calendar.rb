class AddLessonToCalendar < ActiveRecord::Migration[5.0]
  def change
    add_reference :calendarupdates, :lesson, foreign_key: true
  end
end
