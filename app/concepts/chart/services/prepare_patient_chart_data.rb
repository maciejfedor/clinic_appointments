# frozen_string_literal: true

module Chart
  module Services
    class PreparePatientChartData < ApplicationService
      def call
        query_data if User::Patient::Model.any?
      end

      private

      def query_data
        User::Patient::Model.all.group_by_year(:date_of_birth).count
      end
    end
  end
end
