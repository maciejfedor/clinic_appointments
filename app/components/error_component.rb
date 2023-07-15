# frozen_string_literal: true

class ErrorComponent < ViewComponent::Base
  def initialize(resource: nil)
    @resource = resource
  end
end
