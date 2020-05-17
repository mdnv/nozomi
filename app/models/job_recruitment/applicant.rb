# frozen_string_literal: true

class JobRecruitment::Applicant < ApplicationRecord
  include LogicalDelete

  enum status: {
    assigned: 0,
    learning: 1,
    no_learning: 2,
    no_examined: 3,
    failed_examination: 4,
    passed_examination: 5,
    enrolmed: 6,
    had_coe: 7,
    emigrated: 8,
    returned: 9
  }

  has_many :examination_results, dependent: :destroy, inverse_of: :application
  has_many :studying_results, dependent: :destroy, inverse_of: :application
  belongs_to :applicant
  belongs_to :job_recruitment

  scope :before_recruited, -> { where arel_table[:status].lt(statuses[:passed_examination]) }
  scope :after_recruited, -> { where arel_table[:status].gt(statuses[:failed_examination]) }

  before_validation :set_passed_examination_date_if_not_exists

  validates :status, presence: true, inclusion: {in: statuses.keys}
  validates :passed_examination_at, allow_blank: true,
                                    date_range: {
                                      less_than_or_equal_to: Time.current.end_of_day,
                                      greater_than_or_equal_to: (Time.current.beginning_of_day - 14.days)
                                    }
  validates :emigrated_at, date_range: {greater_than_or_equal_to: Date.current.in_time_zone}, allow_blank: true
  validates :immigrated_at, date_range: {greater_than_or_equal_to: Date.current.in_time_zone}, allow_blank: true

  delegate :expected_emigrate_at, :company_vi_name, :company_ja_name, :supervising_organization_vi_name,
           :supervising_organization_ja_name, :occupation_vi_name, :occupation_ja_name, :entering_form_at,
           to: :job_recruitment, allow_nil: true

  accepts_nested_attributes_for :examination_results, :studying_results

  def after_recruited?
    JobRecruitment::Applicant.statuses[status] >= JobRecruitment::Applicant.statuses[:passed_examination]
  end

  private

  def set_passed_examination_date_if_not_exists
    self.passed_examination_at = Time.zone.now if passed_examination_at.blank? && after_recruited?
  end
end
