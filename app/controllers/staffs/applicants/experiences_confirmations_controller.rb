# frozen_string_literal: true

module Staffs
  module Applicants
    class ExperiencesConfirmationsController < BaseController
      before_action :find_applicant_experiences

      def edit; end

      def update
        service = Staffs::UpdateExperiencesConfirmationService.new @applicant, params, current_language
        @experiences_confirmation.update! service.params
        service.synchronize_data_between_all_languages(@experiences_confirmation)
        flash.now[:success] = I18n.t('notifications.update_applicant_experiences_confirmations_successfully')
      end

      private

      def find_applicant_experiences
        @applicant = Applicant.find params[:applicant_id]
        @experiences_confirmation = @applicant.experiences_confirmations
                                              .find_or_initialize_by language: current_language
      end
    end
  end
end
