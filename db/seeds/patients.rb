# frozen_string_literal: true

module Seeds
  class Patients < Base
    execute! do
      DataImport::ImportPatients.call
    end
  end
end
