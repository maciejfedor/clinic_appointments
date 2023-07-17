# frozen_string_literal: true

class StartTimeValidator < Base
  # rubocop:disable Metrics/AbcSize
  def validate(record)
    record.errors.add(:start_time, "can't be in the past") if record.start_time.present? && record.start_time < Time.now

    unless record.start_time.hour.between?(WORKING_HOURS[:start],
                                           WORKING_HOURS[:end] - 1)
      record.errors.add(:start_time, "must be within working hours")
    end

    record.errors.add(:start_time, "must be on working day")   unless (1..5).cover?(record.start_time.wday)

    record.errors.add(:start_time, "must be in a slot") unless minute_slots.include?(record.start_time.min)
  end
  # rubocop:enable Metrics/AbcSize
end
