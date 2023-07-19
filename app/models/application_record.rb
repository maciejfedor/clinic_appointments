# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.implicit_order_column = "created_at"

  class << self
    attr_writer :model_name

    def model_name
      if @model_name
        ActiveModel::Name.new(self, nil, @model_name)
      else
        super
      end
    end
  end
end
