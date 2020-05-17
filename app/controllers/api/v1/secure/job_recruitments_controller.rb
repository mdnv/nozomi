# frozen_string_literal: true

module Api
  module V1
    module Secure
      class JobRecruitmentsController < SecureApiController
        before_action :find_applicant, only: %i[show]

        def show
          @job_recruitment = JobRecruitment.includes(:supervising_organization)
                                           .find_by id: params[:id]
          @applied_job = @applicant.applications
                                   .available
                                   .find_by job_recruitment_id: params[:id]
        end

        private

        def find_applicant
          @applicant = Applicant.find params[:applicant_id]
        end
      end
    end
  end
end
