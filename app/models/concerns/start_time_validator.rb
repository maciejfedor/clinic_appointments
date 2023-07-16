# frozen_string_literal: true

class StartTimeValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:start_time, "can't be in the past") if record.start_time.present? && record.start_time < Time.now
    if record.start_time.present? && record.start_time.hour.between?(WORKING_HOURS[:start],
                                                                     WORKING_HOURS[:end] - APPOINTMENT_DURATION)
      record.errors.add(:start_time, "must be within working hours")
    end
  end
end
