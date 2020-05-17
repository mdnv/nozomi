# frozen_string_literal: true

module Staffs
  module JobRecruitmentsHelper
    include SupervisingOrganizationsHelper
    include CompaniesHelper
    include OccupationHelper

    def job_recruitments_for_applicant_select(selected_value)
      options = ::JobRecruitment.available
                                .joins(:occupation, :company)
                                .pluck(:id, :"occupations.#{I18n.locale}_name", :"companies.#{I18n.locale}_name")
                                .map { |item| [item.first, "#{item.second} - #{item.third}"] }
      options_from_collection_for_select(options, :first, :second, selected_value)
    end
  end
end
