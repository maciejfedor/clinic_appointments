# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :set_patient, only: %i[new create]

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(start_time: date_and_slot_to_start_time))

    if @appointment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.permit(:patient_id, :doctor_id, :price)
  end

  def date_and_slot_to_start_time
    date = params[:date]
    slot = params[:slot]
    Time.zone.parse("#{date} #{slot}")
  end

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
end
