# frozen_string_literal: true

module Seeds
  class Doctors < Base
    DOCTOR_NAMES = %w[Adam Jane John Edward].freeze

    execute! do
      doctors_data = []
      DOCTOR_NAMES.each do |name|
        doctors_data << { first_name: name, last_name: "Doctor" }
        Doctor.insert_all(doctors_data, unique_by: %i[first_name last_name])
      end
    end
  end
end
