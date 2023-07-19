# frozen_string_literal: true

# == Schema Information
#
# Table name: doctors
#
#  id         :uuid             not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_doctors_on_first_name_and_last_name  (first_name,last_name) UNIQUE

module User
  module Doctor
    class Model < ApplicationRecord
      has_person_name

      # Basics
      self.table_name = :doctors
      self.model_name = "Doctor"

      # Validations
      validates :first_name, presence: true
      validates :last_name, presence: true

      # Associations
      has_many :appointments, class_name: "Appointment::Model", dependent: :destroy
      has_many :patients, class_name: "User::Patient::Model", through: :appointments
    end
  end
end
