# frozen_string_literal: true

class Base < ActiveModel::Validator
  def minute_slots
    slots = []
    (60 / APPOINTMENT_DURATION).times do |i|
      slots << (i * APPOINTMENT_DURATION)
    end
    slots
  end
  
  def date_in_the_past?(record)
    Time.now.strftime("%H%M") > record.start_time.strftime("%H%M")
  end
end
