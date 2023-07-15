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
class Doctor < ApplicationRecord
  has_person_name

  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates :first_name, presence: true
  validates :last_name, presence: true
end
