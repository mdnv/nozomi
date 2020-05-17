# frozen_string_literal: true

module Staffs
  module CompaniesHelper
    include SupervisingOrganizationsHelper
    def companies_for_select
      Company.pluck(:id, :"#{I18n.locale}_name", :address).map { |o| [o.second, o.first] }
    end

    def companies_for_select_seach
      Company.pluck(:id, :address).map { |o| [o.second, o.first] }
    end
  end
end
