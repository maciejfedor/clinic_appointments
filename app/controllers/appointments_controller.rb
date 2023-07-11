# frozen_string_literal: true

class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
  end
end
