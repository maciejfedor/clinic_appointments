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
module Appointment
  class Model < ApplicationRecord
    # Basics
    self.table_name = :appointments
    self.model_name = "Appointment"

    # Associations
    belongs_to :doctor, class_name: "User::Doctor::Model"
    belongs_to :patient, class_name: "User::Patient::Model"
    counter_culture :patient, class_name: "User::Patient::Model", column_name: "appointments_count"

    # Validations
    validates :start_time, presence: true
    validates :price,      presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates_with Appointment::Validators::StartTimeValidator

    # Scopes
    # default_scope { order(created_at: :desc) }

    # Methods
    def date
      start_time.to_date if start_time.present?
    end
  end
end
