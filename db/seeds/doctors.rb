# frozen_string_literal: true

module Seeds
  class Doctors < Base
    DOCTOR_NAMES = %w[Adam Jane John Edward].freeze

    execute! do
      DOCTOR_NAMES.each do |name|
        Doctor.first_or_create!(first_name: name, last_name: "Doctor")
      end
    end
  end
end
