# frozen_string_literal: true

require "csv"

module DataImport
  class ImportPatients < Base
    # Docs regarding reading gender and DOB from PESEL number:
    # https://www.gov.pl/web/cyfryzacja/co-to-jest-numer-pesel-i-jak-sie-go-nadaje

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
          first_name: patient[:first_name].capitalize,
          last_name: patient[:last_name].capitalize,
          gender: gender(patient[:pesel]),
          date_of_birth: date_of_birth(patient[:pesel]),
          city: patient[:city].capitalize,
        }
      end
    end

    def create_patients(records)
      User::Patient::Model.upsert_all(records, unique_by: :uid)
    end

    def date_of_birth(uid)
      Parsers::UidParser.parse_date_of_birth(uid)
    end

    def gender(uid)
      Parsers::UidParser.parse_gender(uid)
    end
  end
end
