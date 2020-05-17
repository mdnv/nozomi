# frozen_string_literal: true

module Staffs
  class ApplicantsController < BaseController
    before_render :find_applicants, only: %i[index destroy]
    before_action :find_applicant, except: %i[index new create]

    def index; end

    def new
      @applicant = Applicant.new
    end

    def create
      @applicant = current_staff.applicants.create applicant_params
      return render_page_with_record_invalid('new') unless @applicant.persisted?

      redirect_to manage_applicant_path(@applicant),
                  flash: {success: I18n.t('notifications.create_applicant_successfully')}
    end

    def edit; end

    def update
      service = Staffs::UpdateApplicantService.new @applicant, params
      return render_page_with_record_invalid('edit') unless service.execute

      redirect_to manage_applicant_path(service.applicant),
                  flash: {success: I18n.t('notifications.update_applicant_successfully')}
    end

    def destroy
      @applicant.destroy
      flash.now[:success] = I18n.t('notifications.destroy_applicant_successfully')
    end

    private

    def find_applicants
      @q = Applicant.available.includes(
        current_application: {
          job_recruitment: [:company, :supervising_organization, :occupation]
        }
      ).ransack query_params
      @applicants = @q.result.order(created_at: :desc).page params[:page]
    end

    def find_applicant
      @applicant = Applicant.find(params[:id])
    end

    def applicant_params
      params.require(:applicant)
            .permit :firstname, :lastname, :fullname, :fullname_katakana, :fullname_kanji,
                    :other_name, :gender, :birthdate, :birthplace, :hometown, :vietnam_address,
                    :vietnam_phone_number, :japan_phone_number, :japan_address, :personal_note
    end
  end
end
