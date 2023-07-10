# frozen_string_literal: true

class PatientsController < ApplicationController
  include Pagy::Backend

  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result, items: 8)
  end
end
