# frozen_string_literal: true

module Appointment
  module Validators
    class StartTimeValidator < ActiveModel::Validator
      def validate(record)
        date_in_the_past?(record)
        date_in_working_hours?(record)
        date_on_a_working_day?(record)
        date_in_a_slot?(record)
      end

      private

      def date_in_the_past?(record)
        return false unless record.start_time.present? && Time.now.strftime("%H%M") > record.start_time.strftime("%H%M")

        record.errors.add :start_time, "can't be in the past"
      end

      def date_in_working_hours?(record)
        return false if record.start_time.present? && record.start_time.hour.between?(WORKING_HOURS[:start],
                                                                                      WORKING_HOURS[:end] - 1)

        record.errors.add :start_time, "must be within working hours"
      end

      def date_on_a_working_day?(record)
        return false if record.start_time.present? && (1..5).cover?(record.start_time.wday)

        record.errors.add :start_time, "must be on working day"
      end

      def date_in_a_slot?(record)
        return false if record.start_time.present? && minute_slots.include?(record.start_time.min)

        record.errors.add :start_time, "must be in a slot"
      end

      def minute_slots
        slots = []
        (60 / APPOINTMENT_DURATION).times do |i|
          slots << (i * APPOINTMENT_DURATION)
        end
        slots
      end
    end
  end
end
