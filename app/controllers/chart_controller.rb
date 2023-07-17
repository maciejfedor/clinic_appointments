# frozen_string_literal: true

class ChartController < ApplicationController
  def show
    report_data = Charts::Services::PreparePatientChartData.call

    categories_data = report_data&.keys || []
    series_data = report_data&.values || []

    @categories = categories_data.to_json
    @series = series_data.to_json
  end
end
