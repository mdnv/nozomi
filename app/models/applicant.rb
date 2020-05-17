# frozen_string_literal: true

require Rails.root.join('app', 'lib', 'regions')

class Applicant < ApplicationRecord
  include Genderable
  include LogicalDelete

  has_one_attached :coe

  ## Associations
  has_many :applications, class_name: JobRecruitment::Applicant.name, inverse_of: :applicant
  has_many :job_recruitments, through: :applications
  has_one  :current_application, -> { available }, class_name: JobRecruitment::Applicant.name,
                                                   inverse_of: :applicant,
                                                   dependent: :destroy
  has_many :resumes, class_name: Applicant::Resume.name, foreign_key: :applicant_id,
                     inverse_of: :applicant,
                     dependent: :destroy
  has_many :experiences_confirmations, dependent: :destroy
  belongs_to :creator, class_name: Staff.name, foreign_key: :creator_id

  # Scope
  scope :by_process_type, lambda { |type|
    # Need refactoring
    if type == 'before_recruited'
      left_joins(:applications)
        .where(job_recruitment_applicants: {applicant_id: nil})
        .or(left_joins(:applications).merge(JobRecruitment::Applicant.available.before_recruited))
        .available
        .distinct
    else
      joins(:applications).merge(JobRecruitment::Applicant.available.after_recruited).available
    end
  }

  ## Validations
  validates_presence_of :firstname, :lastname, :fullname, :birthdate, :birthplace
  validates_length_of :firstname, :lastname, :fullname, :birthplace, :fullname,
                      :fullname_katakana, :fullname_kanji, :other_name, :birthplace,
                      :vietnam_address, :japan_address, maximum: 255
  validates :gender, presence: true, inclusion: {in: genders.keys}
  validates :hometown, presence: true, inclusion: {in: Regions::VIETNAM}
  validates :vietnam_phone_number, presence: true, length: {in: 9..15}, format: {with: Settings.regex.phone_number}
  validates :japan_phone_number, length: {in: 9..15}, format: {with: Settings.regex.phone_number}, allow_blank: true
  validates :personal_note, length: {maximum: 10_000}
  validates :birthdate, date_range: {
    between: Settings.applicant.birthdate_minimum..(Date.current - Settings.applicant.minimum_age.years)
  }

  ## Delegations
  delegate :username, to: :creator, prefix: true, allow_nil: true
  # To JobRecruitment
  delegate :expected_emigrate_at, :supervising_organization_vi_name, :supervising_organization_ja_name,
           :company_vi_name, :company_ja_name, :occupation_vi_name, :occupation_ja_name, :occupation_id,
           :job_recruitment_id, :entering_form_at, to: :current_application, prefix: true, allow_nil: true
  delegate :id, :emigrated_at, :immigrated_at, :status, :passed_examination_at,
           to: :current_application, prefix: true, allow_nil: true

  ## Nested attributes
  accepts_nested_attributes_for :current_application

  ## Ransack
  ransack_alias :supervising_organization_id, :current_application_job_recruitment_supervising_organization_id
  ransack_alias :company_id, :current_application_job_recruitment_company_id
  ransack_alias :occupation_id, :current_application_job_recruitment_occupation_id
  ransack_alias :expected_emigrate_at, :current_application_job_recruitment_expected_emigrate_at

  def self.ransackable_scopes(_auth_object = nil)
    [:by_process_type]
  end

  def current_process_type
    return :after_recruited if current_application&.after_recruited?

    :before_recruited
  end

  def age
    return if birthdate.blank?

    Time.zone.now.year - birthdate.year
  end
end
