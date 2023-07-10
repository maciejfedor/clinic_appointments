# frozen_string_literal: true

class PatientsController < ApplicationController
  include Pagy::Backend

  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result(distinct: true), items: 8)
  end
end
