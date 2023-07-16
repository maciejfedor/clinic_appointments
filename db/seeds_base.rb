Rails.logger = Logger.new(STDOUT)

module Seeds
  class Base
    class << self
      def execute!
        ActiveRecord::Base.establish_connection
        return unless block_given?

        ActiveRecord::Base.transaction do
          Rails.logger.info "#{Time.zone.now.strftime("%Y/%m/%d %H:%M:%S")} START SEEDING #{self.name.demodulize.upcase} "

          yield

          Rails.logger.info "#{Time.zone.now.strftime("%Y/%m/%d %H:%M:%S")} END SEEDING #{self.name.demodulize.upcase} "
        end
        end

      def minute_slots
        slots = []
        (60 / APPOINTMENT_DURATION).times do |i|
          slots << (i * APPOINTMENT_DURATION)
        end
        slots
      end

      def generate_random_time(_doctor)
        loop do
          slots = minute_slots
          hour = rand(WORKING_HOURS[:start]..WORKING_HOURS[:end] - 1)
          min = slots.sample
          date = DateTime.current + rand(1..12).weeks
          date = date.change(hour:, min:)

          next if (1..5).cover?(date.wday)

          break date
        end
      end
    end
  end
end
