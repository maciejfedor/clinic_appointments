# frozen_string_literal: true

require "csv"

module DataImport
  class ImportPatients < Base
    FILE_PATH = "#{Rails.root}/db/data/patients_import/fake_medical_patients.csv".freeze
    BATCH_SIZE = 1000 # Adjust the batch size as needed

    def initialize
      @source_file = CSV.open(FILE_PATH, headers: true, header_converters: :symbol)
    end

    def call
      raise StandardError, "File not found" unless @source_file

      log_info "PATIENTS IMPORT STARTED..."

      @source_file.each_slice(BATCH_SIZE) do |batch|
        patient_records = build_patient_records(batch)
        create_patients(patient_records)
      end
      log_info "PATIENTS IMPORT FINISHED!"
    end

    private

    def build_patient_records(records)
      records.map do |patient|
        {
          uid: patient[:pesel],
          first_name: patient[:first_name],
          last_name: patient[:last_name],
          gender: gender(patient[:pesel]),
          date_of_birth: date_of_birth(patient[:pesel]),
          city: patient[:city],
        }
      end
    end

    def create_patients(records)
      Patient.upsert_all(records, unique_by: :uid)
    end

    def date_of_birth(uid)
      year, month, day = uid[0..1], uid[2..3], uid[4..5]

      if month.to_i > 12
        month = month.to_i - 20
        year = "20#{year}"
      else
        year = "19#{year}"
      end
      Date.new(year.to_i, month.to_i, day.to_i)
    end

    def gender(uid)
      gender_number = uid[9].to_i
      gender_number.even? ? "Female" : "Male"
    end
  end
end
