# frozen_string_literal: true

class PatientsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @patients = pagy(Patient.all, items: 8)
  end
end
