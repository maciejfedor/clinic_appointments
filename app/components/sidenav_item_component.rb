# frozen_string_literal: true

class SidenavItemComponent < ViewComponent::Base
  def initialize(label:, link:)
    @label = label
    @link = link
  end

  private

  def active
    "bg-gray-200"
  end

  def inactive
    "hover:bg-gray-200"
  end

  def svg
    "#{@label.downcase}.svg"
  end
end
