# frozen_string_literal: true

class SupervisingOrganization < ApplicationRecord
  include LogicalDelete

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  enum status: {inactive: 0, active: 1}

  has_many :companies, dependent: :destroy
  has_one_attached :avatar
  has_many :job_recruitments, counter_cache: true, dependent: :destroy

  def amount_of_applicants_working_in_japan
    JobRecruitment::Applicant.joins(:job_recruitment)
                             .available.emigrated
                             .merge(JobRecruitment.available.where(supervising_organization_id: id))
                             .count
  end

  validates :username, presence: true, length: {in: 6..20}

  delegate :supervising_organization_id, to: :job_recruitments, prefix: true, allow_nil: true

  def avatar_image(size = Settings.images.sizes.avatar)
    return format(Settings.images.default_avatar, size: size) unless avatar.attached?

    avatar.variant(resize: "#{size}x#{size}").processed
  end
end
