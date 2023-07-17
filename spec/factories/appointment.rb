require "./spec/support/time_slots"

FactoryBot.define do
  factory :appointment do
    patient
    doctor
    start_time { "2024-03-26 14:40" }
    price { 100 }

    trait :with_random_start_time do
      after(:build) do |appointment|
        appointment.start_time = generate_random_time
      end
    end
  end
end
