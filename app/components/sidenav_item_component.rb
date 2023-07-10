# frozen_string_literal: true

class SidenavItemComponent < ViewComponent::Base
  def initialize(label:, link:)
    @label = label
    @link = link
  end

  private

  def sidenav_item_class
    [
      (active? ? active_sidenav_item_class : inactive_sidenav_item_class).to_s,
      "flex items-center px-4 py-2 mt-5 rounded-md",
    ].join(" ")
  end

  def active_sidenav_item_class
    "bg-gray-200"
  end

  def inactive_sidenav_item_class
    "hover:bg-gray-200"
  end

  def active?
    current_page?(@link)
  end
end
