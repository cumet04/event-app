# frozen_string_literal: true

# Base class for all ActiveModel
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
