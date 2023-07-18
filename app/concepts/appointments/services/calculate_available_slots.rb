# frozen_string_literal: true

module Appointments
  module Services
    class CalculateAvailableSlots < ApplicationService
      def initialize(doctor_id:, appointment_date:)
        @doctor = Doctor.find(doctor_id)
        @appointment_date = appointment_date.to_datetime
        @doctor_appointments = preload_appointments
      end

      def call
        time_slots = []
        (WORKING_HOURS[:start]...WORKING_HOURS[:end]).each do |hour|
          0.upto(slots_per_hour - 1) do |minute|
            slot = @appointment_date.change(hour:, min: minute * APPOINTMENT_DURATION)
            time_slots << slot.strftime("%H:%M") unless taken?(slot)
          end
        end
        time_slots
      end

      private

      def slots_per_hour
        (60 / APPOINTMENT_DURATION)
      end

      def preload_appointments
        @doctor.appointments
               .where(start_time: @appointment_date.beginning_of_day..@appointment_date.end_of_day)
               .pluck(:start_time)
      end

      def taken?(slot)
        slot_time = Time.parse(slot.strftime("%H:%M"))
        Time.now >= slot_time || @doctor_appointments.include?(slot)
      end
    end
  end
end
