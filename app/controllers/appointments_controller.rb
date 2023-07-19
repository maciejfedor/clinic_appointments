# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :set_patient, only: %i[new create]
  before_action :set_appointment, only: %i[edit update destroy]
  before_action :set_appointments, only: %i[index]

  def index
    @pagy, @appointments = pagy(@appointments, items: 6)
  end

  def new
    @appointment = Appointment::Model.new
  end

  def create
    @appointment = Appointment::Model.new(appointment_params.merge(start_time: date_and_slot_to_start_time,
                                                                   patient_id: params[:patient_id]))

    if @appointment.save
      flash[:success] = "Appointment created successfully!"
      redirect_to all_appointments_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @appointment.update(appointment_params.merge(start_time: date_and_slot_to_start_time))
      flash[:notice] = "Appointment updated successfully!"
      redirect_to all_appointments_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    flash[:notice] = "Appointment deleted successfully!"
    redirect_to all_appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id, :price)
  end

  def date_and_slot_to_start_time
    date = params[:appointment][:date]
    slot = params[:appointment][:slot]
    Time.zone.parse("#{date} #{slot}")
  end

  def set_patient
    @patient = User::Patient::Model.find(params[:patient_id])
  end

  def set_appointment
    @appointment = Appointment::Model.find(params[:id])
  end

  def set_appointments
    @appointments = if params[:patient_id].present?
                      Appointment::Model.where(patient_id: params[:patient_id]).includes(:doctor, :patient).all
                    else
                      Appointment::Model.includes(:doctor, :patient).all
                    end
  end
end
