# frozen_string_literal: true

class AvailableSlotsController < ApplicationController
  def show
    doctor_id = params[:doctor_id]
    appointment_date = params[:appointment_date]

    slots = ::Appointment::Services::CalculateAvailableSlots.call(doctor_id:,
                                                                  appointment_date:)

    render json: slots
  end
end
