# frozen_string_literal: true

class PatientComponent < ViewComponent::Base
  with_collection_parameter :patient

  def initialize(patient:)
    @patient = patient
  end
end
