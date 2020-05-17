# frozen_string_literal: true

module Organizations
  module JobRecruitment
    class ApplicantPolicy < ApplicationPolicy
      attr_reader :current_supervising_organization, :job_recruitment

      def initialize(_current_staff, job_recruitment)
        @current_staff = current_supervising_organization
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
