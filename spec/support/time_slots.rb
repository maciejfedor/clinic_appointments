def minute_slots
  slots = []
  (60 / APPOINTMENT_DURATION).times do |i|
    slots << (i * APPOINTMENT_DURATION)
  end
  slots
end

def generate_random_time
  slots = minute_slots
  loop do
    hour = rand(WORKING_HOURS[:start]...WORKING_HOURS[:end])
    min = slots.sample
    date = DateTime.current + rand(1..90).days
    date = date.change(hour:, min:)

    next unless (1..5).cover?(date.wday)

    break date
  end
end
