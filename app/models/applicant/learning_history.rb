# frozen_string_literal: true

class Applicant::LearningHistory < JsonDataModel
  def initialize(data = nil)
    super Applicant::LearningPeriod, data
  end
end

class Applicant::LearningPeriod
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations
  include Helpers::YearMonthValidatorHelper

  ATTRIBUTES = [:from_year, :to_year, :from_month, :to_month, :school, :major].freeze

  attr_accessor(*ATTRIBUTES)

  validates :from_year, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: Settings.minimum_year,
    less_than_or_equal_to: Date.current.year
  }
  validates :to_year, presence: true, numericality: {
    only_integer: true,
    less_than_or_equal_to: Date.current.year,
    greater_than_or_equal_to: ->(record) { Helpers::YearMonthValidatorHelper.year_greater_than_or_equal_to(record) }
  }
  validates :from_month, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  validates :to_month, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: ->(record) { Helpers::YearMonthValidatorHelper.month_greater_than_or_equal_to(record) },
    less_than_or_equal_to: 12
  }
  validates :school, presence: true, length: {maximum: 255}
  validates :major, presence: true, length: {maximum: 255}

  def initialize(data = {})
    @from_year = data['from_year']
    @to_year = data['to_year']
    @from_month = data['from_month']
    @to_month = data['to_month']
    @school = data['school']
    @major = data['major']
  end

  def exists_data?
    ATTRIBUTES.any? { |attribute| send(attribute).present? }
  end
end
