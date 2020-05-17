# frozen_string_literal: true

class Staff < ApplicationRecord
  include LogicalDelete
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable, :rememberable
  devise :database_authenticatable, :recoverable, :validatable

  enum role: {standard: 0, manager: 1, administrator: 8, super_administrator: 9}
  enum status: {inactive: 0, active: 1}

  has_many :applicants, class_name: Applicant.name, foreign_key: :creator_id
  has_one_attached :avatar
  belongs_to :department

  validates :username, presence: true, length: {in: 6..20}
  validates :status, presence: true, inclusion: {in: statuses.keys}
  validates :role, presence: true, inclusion: {in: roles.keys}
  validates :email, presence: true, uniqueness: true, format: {with: Devise.email_regexp},
                    allow_nil: true

  delegate :vi_name, to: :department, prefix: true, allow_nil: true
  delegate :ja_name, to: :department, prefix: true, allow_nil: true

  validates :email, presence: true, uniqueness: true, format: {with: Devise.email_regexp}
  def avatar_image(size = Settings.images.sizes.avatar)
    return format(Settings.images.default_avatar, size: size) unless avatar.attached?

    avatar.variant(resize: "#{size}x#{size}").processed
  end
end
