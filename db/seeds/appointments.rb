# frozen_string_literal: true

module Seeds
  class Appointments < Base
    execute! do
      patients = Patient.all
      doctors = Doctor.all
      appointment_records = []

      5000.times do
        patient = patients.sample
        doctor = doctors.sample

        start_time = generate_random_time(doctor)

        appointment_params = {
          patient_id: patient.id,
          doctor_id: doctor.id,
          price: rand((10 / 50)..(1000 / 50)) * 50,
          start_time:,
        }

        appointment_records << appointment_params
      end
      Appointment.insert_all(appointment_records, unique_by: %i[start_time doctor_id patient_id])
      Appointment.counter_culture_fix_counts
    end
  end
end
