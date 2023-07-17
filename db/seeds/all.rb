# frozen_string_literal: true

module Seeds
  class All < Base
    SEEDING_ORDER = %w[
      patients
      doctors
      appointments
    ].freeze

    SEEDING_ORDER
      .map { |filename| File.join(Rails.root, "db", "seeds", "#{filename}.rb") }
      .each { |file| load(file) }
  end
end
