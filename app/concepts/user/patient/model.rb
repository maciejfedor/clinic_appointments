# frozen_string_literal: true

# == Schema Information
#
# Table name: patients
#
#  id                 :uuid             not null, primary key
#  appointments_count :integer          default(0), not null
#  city               :string           not null
#  date_of_birth      :date             not null
#  first_name         :string           not null
#  gender             :string           not null
#  last_name          :string           not null
#  uid                :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_patients_on_uid  (uid) UNIQUE
#
module User
  module Patient
    class Model < ApplicationRecord
      has_person_name

      # Basics
      self.table_name = :patients
      self.model_name = "Patient"

      # Associations
      has_many :appointments, class_name: "Appointment::Model", dependent: :destroy
      has_many :doctors, class_name: "Doctor::Model", through: :appointments

      # Validations
      validates :first_name, presence: true
      validates :last_name, presence: true
      validates :gender, presence: true
      validates :date_of_birth, presence: true
      validates :city, presence: true

      # uid is a unique identifier for a patient in the system
      # it is a PESEL number for polish patients
      validates :uid, presence: true, uniqueness: true

      # Enums
      enum gender: {
        male: "Male",
        female: "Female",
      }

      def self.ransackable_attributes(_auth_object = nil)
        %w[city date_of_birth gender last_name]
      end
    end
  end
end
