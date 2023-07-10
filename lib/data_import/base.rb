# frozen_string_literal: true

module DataImport
  class Base
    def log_info(message)
      Rails.logger.info("\n\x1b[31m#{message}\033[0m\n")
    end

    def self.call(...)
      new(...).call
    end
  end
end
