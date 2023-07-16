# frozen_string_literal: true

module Charts
  module Services
    class PreparePatientChartData < ApplicationService
      def call
        query_data
      end

      private

      def query_data
        Patient.all.group_by_year(:date_of_birth).count
      end
    end
  end
end
