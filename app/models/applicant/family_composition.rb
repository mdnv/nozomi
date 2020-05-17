# frozen_string_literal: true

class Applicant::FamilyComposition < JsonDataModel
  def initialize(data = nil)
    super Applicant::FamilyMember, data
  end
end

class Applicant::FamilyMember
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations

  ATTRIBUTES = [:fullname, :relationship, :age, :phone_number, :occupation, :income].freeze

  attr_accessor(*ATTRIBUTES)

  validates :fullname, presence: true, length: {maximum: 200}
  validates :relationship, presence: true, length: {maximum: 200}
  validates :age, presence: true, numericality: {only_integer: true,
                                                 greater_than_or_equal_to: 1,
                                                 less_than: Settings.person.maximum_age}
  validates :phone_number, length: {in: 9..15},
                           format: {with: Settings.regex.phone_number},
                           if: -> { phone_number.present? }
  validates :occupation, length: {maximum: 255}
  validates :income, length: {maximum: 255}

  def initialize(data = {})
    @fullname = data['fullname']
    @relationship = data['relationship']
    @age = data['age']
    @phone_number = data['phone_number']
    @occupation = data['occupation']
    @income = data['income']
  end

  def exists_data?
    ATTRIBUTES.any? { |attribute| send(attribute).present? }
  end
end
