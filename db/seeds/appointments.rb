# Using create! within that seed is time consuming, but it's a good way to ensure that the data is valid.
module Seeds
  class Appointments < Base
    execute! do
      patients = User::Patient::Model.all
      doctors = User::Doctor::Model.all
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

        appointment_records << appointment_params

        
      end
      Appointment::Model.insert_all(appointment_records, unique_by: %i[start_time doctor_id patient_id] )
      Appointment::Model.counter_culture_fix_counts
    end
  end
end
