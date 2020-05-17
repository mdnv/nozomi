# frozen_string_literal: true

module Staffs
  module JobRecruitment
    class ApplicantPolicy < ApplicationPolicy
      attr_reader :current_staff, :job_recruitment

      def initialize(current_staff, job_recruitment)
        @current_staff = current_staff
        @job_recruitment = job_recruitment
      end

      def disenroll?
        job_recruitment.persisted?
      end

      def set_failed_examination?
        statuses = ::JobRecruitment::Applicant.statuses
        job_recruitment.persisted? && \
          job_recruitment.status.present? && \
          statuses[job_recruitment.status] < statuses[:failed_examination]
      end
    end
  end
end
