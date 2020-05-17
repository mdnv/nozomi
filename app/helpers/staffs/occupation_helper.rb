# frozen_string_literal: true

module Staffs
  module OccupationHelper
    def occupation_for_select_search
      Occupation.pluck(:id, :"#{I18n.locale}_name").map do |o|
        [o.second, o.first]
      end
    end
  end
end
