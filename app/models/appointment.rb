# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id         :uuid             not null, primary key
#  price      :decimal(8, 2)    not null
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  doctor_id  :uuid             not null
#  patient_id :uuid             not null
#
# Indexes
#
#  index_appointments_on_doctor_id                                (doctor_id)
#  index_appointments_on_patient_id                               (patient_id)
#  index_appointments_on_start_time_and_doctor_id_and_patient_id  (start_time,doctor_id,patient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => doctors.id)
#  fk_rails_...  (patient_id => patients.id)
#
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  counter_culture :patient

  validates :start_time, presence: true
  validates :price,      presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates_with StartTimeValidator

  default_scope { order(created_at: :desc) }
end
