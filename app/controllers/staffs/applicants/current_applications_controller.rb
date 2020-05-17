# frozen_string_literal: true

module Staffs
  module Applicants
    class CurrentApplicationsController < BaseController
      before_action :find_applicant

      def destroy
        @applicant.current_application.destroy
        redirect_to manage_applicant_path(@applicant),
                    flash: {success: I18n.t('notifications.disenroll_job_recruitment_successfully')}
      end

      def update
        @applicant.current_application.update! availability: :unavailable,
                                               status: :failed_examination
        redirect_to manage_applicant_path(@applicant),
                    flash: {success: I18n.t('notifications.update_applicant_successfully')}
      end

      private

      def find_applicant
        @applicant = Applicant.find params[:applicant_id]
      end
    end
  end
end
