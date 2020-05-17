# frozen_string_literal: true

module Staffs
  class UpdateApplicantService
    attr_accessor :applicant

    def initialize(applicant, params)
      @applicant = applicant
      @params = filter(params)
    end

    def execute
      remove_job_id unless update_current_job?
      @applicant.update @params
    end

    private

    def new_job_id
      @params.dig(:current_application_attributes, :job_recruitment_id).to_i
    end

    def update_current_job?
      new_job_id == 0 || @applicant.current_application_job_recruitment_id == new_job_id.to_i
    end

    def remove_job_id
      @params[:current_application_attributes].delete :id
    end

    def filter(params)
      params.require(:applicant)
            .permit :firstname, :lastname, :fullname, :fullname_katakana, :fullname_kanji, :other_name,
                    :gender, :birthdate, :birthplace, :hometown, :vietnam_phone_number, :japan_phone_number,
                    :japan_address, :personal_note, :vietnam_address, current_application_attributes: [
                      :id, :job_recruitment_id, :status, :emigrated_at,
                      :immigrated_at, :passed_examination_at,
                      examination_results_attributes: [
                        :id, :subject, :mark, :job_recruitment_id, :job_recruitment_applicant_id
                      ]
                    ]
    end
  end
end
