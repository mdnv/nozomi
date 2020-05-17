# frozen_string_literal: true

module Staffs
  module Applicants
    class ExaminationResultsController < BaseController
      before_action :find_applicant, except: %i[cancel]
      before_action :find_examination_result, only: %i[edit update destroy]
      before_action :find_available_examination_results, only: %i[index close]

      def index; end

      def new; end

      def create
        @examination_result = @applicant.current_application.examination_results.build(examination_result_params)
        @examination_result.job_recruitment_id = @applicant.current_application.job_recruitment_id
        @examination_result.save!
        flash.now[:success] = I18n.t('notifications.create_examination_result_successfully')
      end

      def edit; end

      def update
        @updated = @examination_result.update! examination_result_params
        flash.now[:success] = I18n.t('notifications.update_examination_result_successfully')
      end

      def destroy
        @examination_result.delete
        flash.now[:success] = I18n.t('notifications.update_examination_result_successfully')
      end

      def cancel
        @cancel_from_edit = params[:from_edit_page] == 'true'
        return unless @cancel_from_edit

        find_applicant
        find_examination_result
      end

      def close; end

      private

      def find_applicant
        @applicant = Applicant.find params[:applicant_id]
      end

      def find_examination_result
        @examination_result = @applicant.current_application.examination_results.find(params[:id])
      end

      def find_available_examination_results
        @examination_results = @applicant.current_application.examination_results.available
      end

      def examination_result_params
        params.require(:examination_result).permit(:subject, :mark)
      end
    end
  end
end
