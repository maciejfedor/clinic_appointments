# frozen_string_literal: true

class Base < ActiveModel::Validator
  def minute_slots
    slots = []
    (60 / APPOINTMENT_DURATION).times do |i|
      slots << (i * APPOINTMENT_DURATION)
    end
    slots
  end
end
