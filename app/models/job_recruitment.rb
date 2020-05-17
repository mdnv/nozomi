# frozen_string_literal: true

class JobRecruitment < ApplicationRecord
  include LogicalDelete

  has_many :applied_applicants, class_name: JobRecruitment::Applicant.name
  belongs_to :supervising_organization
  belongs_to :occupation
  belongs_to :company

  delegate :vi_name, :ja_name, :address, to: :company, prefix: true, allow_nil: true
  delegate :vi_name, :ja_name, to: :supervising_organization, prefix: true, allow_nil: true
  delegate :id, :vi_name, :ja_name, to: :occupation, prefix: true, allow_nil: true
end
