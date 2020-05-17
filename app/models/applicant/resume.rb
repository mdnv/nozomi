# frozen_string_literal: true

class Applicant::Resume < ApplicationRecord
  include Languagable
  include LogicalDelete

  attr_accessor :family_composition, :learning_histories, :working_histories

  enum blood_type: {o: 0, a: 1, b: 2, ab: 3}, _prefix: true
  enum forehand: {left: 0, right: 1}, _prefix: true
  enum tattoo: {has_not: 0, has: 1}, _suffix: true
  enum marital_status: {married: 0, single: 1, divorced: 2, separated: 3}
  enum passport: {has_not: 0, has: 1}, _suffix: true
  enum gone_to_japan: {has_not: 0, has: 1}, _suffix: true
  enum relative_in_japan: {has_not: 0, has: 1}, _suffix: true

  belongs_to :applicant

  after_initialize :parse_json_data_of_attributes
  before_validation :set_text_fields_depends_on_toggle_fields, :set_json_data_to_attributes

  validates :permanent_place_of_residence, length: {maximum: 255}
  validates :family_tel, length: {in: 9..15}, format: {with: Settings.regex.phone_number}, allow_blank: true
  validates :blood_type, inclusion: {in: blood_types.keys}, allow_blank: true

  validates :forehand, inclusion: {in: forehands.keys}, allow_blank: true
  validates :tattoo, inclusion: {in: tattoos.keys}, allow_blank: true
  validates :height, numericality: {greater_than_or_equal_to: 130, less_than: 1_000},
                     length: {maximum: 255},
                     allow_blank: true
  validates :weight, numericality: {greater_than_or_equal_to: 30, less_than: 1_000},
                     length: {maximum: 255},
                     allow_blank: true
  validates :left_eyesight, numericality: {greater_than_or_equal_to: 0, less_than: 1_000},
                            length: {maximum: 255},
                            allow_blank: true
  validates :right_eyesight, numericality: {greater_than_or_equal_to: 0, less_than: 1_000},
                             length: {maximum: 255},
                             allow_blank: true

  validates :marital_status, inclusion: {in: marital_statuses.keys}, allow_blank: true
  validates :hobbies, length: {maximum: 1_000}
  validates :strong_points, length: {maximum: 1_000}

  validates :expectation_after_work, length: {maximum: 1_000}
  validates :goals_after_returned, length: {maximum: 1_000}
  validates :long_term_goals, length: {maximum: 1_000}
  validates :passport, inclusion: {in: passports.keys}, allow_blank: true
  validates :gone_to_japan, inclusion: {in: gone_to_japans.keys}, allow_blank: true
  validates :relative_in_japan, inclusion: {in: relative_in_japans.keys}, allow_blank: true
  validates :gone_reason, presence: true, length: {maximum: 255}, if: -> { has_gone_to_japan? }

  with_options if: -> { has_passport? } do
    validates :passport_number, presence: true, length: {in: 5..10}
    validates :passport_issued_at, presence: true, date_range: {
      between: (Date.current - 15.years)..(Date.current + 15.years),
      message: I18n.t('errors.messages.invalid')
    }
  end

  with_options if: -> { has_relative_in_japan? } do
    validates :relative_fullname, presence: true, length: {maximum: 255}
    validates :relative_relationship, presence: true, length: {maximum: 255}
  end

  validate :validate_json_data_of_attributes

  private

  def parse_json_data_of_attributes
    set_json_data_to_attributes if [@family_composition, @learning_histories, @working_histories].any?(&:blank?)
  end

  def set_json_data_to_attributes
    @family_composition = Applicant::FamilyComposition.new(family_composition_json)
    @learning_histories = Applicant::LearningHistory.new(learning_histories_json)
    @working_histories = Applicant::WorkingHistory.new(working_histories_json)
  end

  def validate_json_data_of_attributes
    errors.add(:family_composition, :invalid) if @family_composition.invalid_data?
    errors.add(:learning_histories, :invalid) if @learning_histories.invalid_data?
    errors.add(:working_histories, :invalid) if @working_histories.invalid_data?
  end

  def set_text_fields_depends_on_toggle_fields
    if has_not_passport?
      self.passport_number = nil
      self.passport_issued_at = nil
    end

    if has_not_relative_in_japan?
      self.relative_fullname = nil
      self.relative_relationship = nil
    end

    self.gone_reason = nil if has_not_gone_to_japan?
  end
end
