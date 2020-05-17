# frozen_string_literal: true

module Staffs
  module Applicants
    class ResumesController < BaseController
      before_action :find_applicant_resume

      def edit; end

      def update
        update_service = Staffs::UpdateResumeService.new @applicant, params, current_language
        @resume.update! update_service.params
        update_service.synchronize_data_between_all_languages(@resume)
        flash.now[:success] = I18n.t('notifications.update_applicant_resume_successfully')
      end

      private

      def find_applicant_resume
        @applicant = Applicant.find params[:applicant_id]
        @resume = @applicant.resumes.find_or_initialize_by(language: current_language)
      end
    end
  end
end
