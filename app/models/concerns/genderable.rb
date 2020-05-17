# frozen_string_literal: true

module Genderable
  extend ActiveSupport::Concern

  GENDERS = {female: 0, male: 1}.freeze

  included do
    enum gender: GENDERS
  end
end
