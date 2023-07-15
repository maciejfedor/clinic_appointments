# frozen_string_literal: true

class FlashComponentPreview < Lookbook::Preview
  def success
    render FlashComponent.new(level: "success", text: "Succesfully created!")
  end
end
