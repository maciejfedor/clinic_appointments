# frozen_string_literal: true

class PatientsController < ApplicationController
  def index
    @q = User::Patient::Model.ransack(params[:q])
    @pagy, @patients = pagy(@q.result(distinct: true).includes(:appointments), items: 6)
  end
end
