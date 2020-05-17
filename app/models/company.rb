# frozen_string_literal: true

class Company < ApplicationRecord
  include LogicalDelete

  has_many :job_recruitments, counter_cache: true, dependent: :destroy
  belongs_to :supervising_organization

  delegate :vi_name, :ja_name, to: :supervising_organization, prefix: true, allow_nil: true
  delegate :supervising_organization_id, to: :job_recruitments, prefix: true, allow_nil: true

  accepts_nested_attributes_for :job_recruitments

  def amount_of_applicants_working_in_japan
    JobRecruitment::Applicant.joins(:job_recruitment)
                             .available.emigrated
                             .merge(JobRecruitment.available.where(company_id: id))
                             .count
  end
end
