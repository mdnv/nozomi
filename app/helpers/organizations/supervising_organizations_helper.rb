# frozen_string_literal: true

module Organizations
  module SupervisingOrganizationsHelper
    def supervising_organizations_for_select
      SupervisingOrganization.pluck(:id, :"#{I18n.locale}_name").map { |o| [o.second, o.first] }
    end
  end
end
