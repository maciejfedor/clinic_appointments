# frozen_string_literal: true

class Base < ActiveModel::Validator
  def minute_slots
    slots = []
    (60 / APPOINTMENT_DURATION).times do |i|
      slots << (i * APPOINTMENT_DURATION)
    end
    slots
  end

  def generate_random_time(_doctor)
    loop do
      slots = minute_slots
      hour = rand(WORKING_HOURS[:start]...WORKING_HOURS[:end])
      min = slots.sample
      date = DateTime.current + rand(1..12).weeks
      date = date.change(hour:, min:)

      next if (1..5).cover?(date.wday)

      break date
    end
  end
end
