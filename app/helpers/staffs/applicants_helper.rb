# frozen_string_literal: true

module Staffs
  module ApplicantsHelper
    include SupervisingOrganizationsHelper
    include JobRecruitmentsHelper
    include CompaniesHelper
    include OccupationHelper

    APPLICANT_STATUSES_FOR_SEARCH = [:before_recruited, :after_recruited].freeze

    PASSED_EXAMINATION_STATUSES = %w[passed_examination enrolmed had_coe emigrated returned].freeze

    def applicant_job_recruitments_options_for_select(job_recruitments, selected_value)
      # Job recruitments format: [id, occupation_name, supervising_organization_name]
      options = job_recruitments.map { |item| [item.first, "#{item.second} - #{item.third}"] }
      options_from_collection_for_select(options, :first, :second, selected_value)
    end

    def applicant_job_recruitment_statuses_for_select
      ::JobRecruitment::Applicant.statuses.except(:failed_examination).map do |name, _v|
        [::JobRecruitment::Applicant.human_attribute_name("status.#{name}"), name]
      end
    end

    def applicant_statuses_for_select_search
      APPLICANT_STATUSES_FOR_SEARCH.map do |name, _v|
        [::JobRecruitment::Applicant.human_attribute_name("process_type.#{name}"), name]
      end
    end

    def examination_result_of(applicant)
      return if applicant.current_application.blank? || applicant.current_application.failed_examination?

      status =  if PASSED_EXAMINATION_STATUSES.include? applicant.current_application_status
                  :passed
                else
                  :not_yet
                end
      ::JobRecruitment::Applicant.human_attribute_name "examination_result.#{status}"
    end
  end
end
