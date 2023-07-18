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
            slot = DateTime.new(@appointment_date.year, @appointment_date.month, @appointment_date.day, hour,
                                minute * APPOINTMENT_DURATION)
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
        date_in_the_past?(slot) || @doctor_appointments.include?(slot)
      end

      def date_in_the_past?(slot)
        Time.now.strftime("%H%M") > slot.strftime("%H%M")
      end
    end
  end
end
