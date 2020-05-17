# frozen_string_literal: true

class Occupation < ApplicationRecord
  has_many :job_recruitments
end
