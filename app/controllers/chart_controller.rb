# frozen_string_literal: true

class ChartController < ApplicationController
  def show
    report_data = Charts::Services::PreparePatientChartData.call

    @categories = report_data.keys.to_json
    @series = report_data.values.to_json
  end
end
