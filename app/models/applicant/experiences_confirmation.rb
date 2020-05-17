# frozen_string_literal: true

class Applicant::ExperiencesConfirmation < ApplicationRecord
  include Languagable
  include LogicalDelete

  enum intern_process: {recommended: 0, expectation_after_interned: 1, other: 2}, _suffix: true
  enum treatment_during_intern: {
    keep_relationship: 0, keep_working: 1, leave_from_work: 2, quit: 3, other: 4
  }, _suffix: :during_intern
  enum plan_after_intern: {back: 0, dont_back: 1, unidentified_plan: 2}, _suffix: :after_intern

  belongs_to :applicant

  before_validation :set_text_fields_depends_on_toggle_fields

  validates :company_name, length: {maximum: 255}, allow_blank: true
  validates :department_name, length: {maximum: 255}, allow_blank: true
  validates :occupation_name, length: {maximum: 255}, allow_blank: true
  validates :creator_name, length: {maximum: 255}, allow_blank: true
  validates :creator_position, length: {maximum: 255}, allow_blank: true
  validates :intern_process, inclusion: {in: intern_processes.keys}, allow_blank: true
  validates :treatment_during_intern, inclusion: {in: treatment_during_interns.keys}, allow_blank: true
  validates :treatment_during_intern_content, presence: true, length: {maximum: 255}, if: -> { other_during_intern? }
  validates :plan_after_intern, inclusion: {in: plan_after_interns.keys}, allow_blank: true

  with_options if: -> { recommended_intern_process? || other_intern_process? } do
    validates :intern_process_content, presence: true, length: {maximum: 255}
  end

  with_options if: -> { back_after_intern? } do
    validates :plan_working_department, presence: true, length: {maximum: 255}
    validates :plan_working_occupation, presence: true, length: {maximum: 255}
    validates :plan_working_place, presence: true, length: {maximum: 255}
  end

  private

  def set_text_fields_depends_on_toggle_fields
    self.intern_process_content = nil if expectation_after_interned_intern_process?
    self.treatment_during_intern_content = nil unless other_during_intern?
    return if back_after_intern?

    self.plan_working_department = nil
    self.plan_working_occupation = nil
    self.plan_working_place = nil
  end
end
