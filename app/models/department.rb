# frozen_string_literal: true

class Department < ApplicationRecord
  include LogicalDelete

  has_many :staffs
end
