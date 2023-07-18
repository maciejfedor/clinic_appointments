# frozen_string_literal: true

module Parsers
  class UidParser
    def self.parse_date_of_birth(uid)
      year, month, day = uid[0..1], uid[2..3], uid[4..5]

      if month.to_i > 12
        month = month.to_i - 20
        year = "20#{year}"
      else
        year = "19#{year}"
      end
      Date.new(year.to_i, month.to_i, day.to_i)
    end

    def self.parse_gender(uid)
      gender_number = uid[9].to_i
      gender_number.even? ? "Female" : "Male"
    end
  end
end
