# frozen_string_literal: true

module Staffs
  module Applicants
    class StudyingResultsController < BaseController
      before_action :find_applicant, except: %i[cancel]
      before_action :find_studying_result, only: %i[edit update destroy]
      before_action :find_available_studying_results, only: %i[index close]

      def index; end

      def new; end

      def create
        @studying_result = @applicant.current_application.studying_results.build(studying_result_params)
        @studying_result.job_recruitment_id = @applicant.current_application.job_recruitment_id
        @studying_result.save!
        flash.now[:success] = I18n.t('notifications.create_studying_result_successfully')
      end

      def edit; end

      def update
        @updated = @studying_result.update! studying_result_params
        flash.now[:success] = I18n.t('notifications.update_studying_result_successfully')
      end

      def destroy
        @studying_result.delete
        flash.now[:success] = I18n.t('notifications.update_studying_result_successfully')
      end

      def cancel
        @cancel_from_edit = params[:from_edit_page] == 'true'
        return unless @cancel_from_edit

        find_applicant
        find_studying_result
      end

      def close; end

      private

      def find_applicant
        @applicant = Applicant.find params[:applicant_id]
      end

      def find_studying_result
        @studying_result = @applicant.current_application.studying_results.find(params[:id])
      end

      def find_available_studying_results
        @studying_results = @applicant.current_application.studying_results.available
      end

      def studying_result_params
        params.require(:studying_result).permit(:subject, :mark, :started_at)
      end
    end
  end
end
