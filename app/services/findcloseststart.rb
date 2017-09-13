class Findcloseststart
  attr_accessor :lesson

  def initialize(lesson)
    @lesson = lesson
  end

  def closest_start(lesson)
    possible_bookings = Booking.where("course = ? AND day > ?", 1, Time.now).where(full: false)
    possible_bookings.select do |possible_booking|
      ((lesson.start - possible_booking.day) / 60 / 60 / 24).abs < ENV['PERIODTOLOOKFORLESSON'].to_i
    end
    if possible_bookings.present?
      possible_bookings = possible_bookings.sort {|a,b| (a.day - lesson.start).abs <=> (b.day - lesson.start).abs}
      possible_bookings.length > 3 ? size = 3 : size = possible_bookings.length - 1
      output = ""
      for i in 0..size
        output += "#{possible_bookings[i].day.day}/#{possible_bookings[i].day.month}/#{possible_bookings[i].day.year} ou "
      end
    else
      period = 0
      day_checked = lesson.start
      until period == lesson.duration
        if Booking.where("day = ? ", day_checked).present? && period > 0
          period -= 1
        elsif Booking.where("day = ? ", day_checked).blank?
          period += 1
        end
        day_checked += 1.day
      end
      output = "#{(day_checked - lesson.duration.day).day}/#{(day_checked - lesson.duration.day).month}/#{(day_checked - lesson.duration.day).year}"
    end
    if output[-3..-1] == "ou "
      output = output[0..-4]
    end
    return output
  end

end
