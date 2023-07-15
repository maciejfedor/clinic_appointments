# frozen_string_literal: true

class PatientsController < ApplicationController
  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result(distinct: true).includes(:appointments), items: 8)
  end
end
