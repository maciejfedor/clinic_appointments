# frozen_string_literal: true

# == Schema Information
#
# Table name: patients
#
#  id            :uuid             not null, primary key
#  date_of_birth :date             not null
#  first_name    :string           not null
#  gender        :string           not null
#  last_name     :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Patient < ApplicationRecord
  has_person_name

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true

  enum gender: {
    male: "Male",
    female: "Female",
  }
end
