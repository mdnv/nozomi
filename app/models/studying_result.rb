# frozen_string_literal: true

class StudyingResult < ApplicationRecord
  include LogicalDelete

  belongs_to :application, class_name: JobRecruitment::Applicant.name,
                           foreign_key: :job_recruitment_applicant_id

  before_validation :standardize_data

  validates :subject, presence: true, length: {maximum: 255}
  validates :mark, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000}
  validates :started_at, presence: true

  private

  def standardize_data
    self.mark = mark.round(2) if mark.present?
  end
end
