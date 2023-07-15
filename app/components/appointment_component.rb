# frozen_string_literal: true

class AppointmentComponent < ViewComponent::Base
  with_collection_parameter :appointment

  def initialize(appointment:)
    @appointment = appointment
  end
end
