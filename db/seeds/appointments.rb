# Using create! within that seed is time consuming, but it's a good way to ensure that the data is valid.
module Seeds
  class Appointments < Base
    execute! do
      patients = Patient.all
      doctors = Doctor.all
      appointment_records = []

      5000.times do
        patient = patients.sample
        doctor = doctors.sample

        start_time = generate_random_time

        appointment_params = {
          patient_id: patient.id,
          doctor_id: doctor.id,
          price: rand((10 / 50)..(1000 / 50)) * 50,
          start_time:,
        }

        Appointment.create!(appointment_params)

      end
    end
  end
end
