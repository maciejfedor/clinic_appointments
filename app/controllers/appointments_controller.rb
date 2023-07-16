# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :set_patient, only: %i[new create]

  def index
    if params[:patient_id].present?
      @pagy, @appointments = pagy(Appointment.where(patient_id: params[:patient_id]).includes(:doctor, :patient).all,
                                  items: 8)
    else
      @pagy, @appointments = pagy(Appointment.includes(:doctor, :patient).all, items: 8)
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(start_time: date_and_slot_to_start_time))

    if @appointment.save
      flash[:success] = "Appointment created successfully!"
      redirect_to all_appointments_path
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
