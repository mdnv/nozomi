# frozen_string_literal: true

module Staffs
  class UpdateExperiencesConfirmationService
    attr_accessor :applicant, :params

    SYNCHRONIZE_BLACKLIST_ATTRIBUTES = %w[deleted_at id].freeze
    SYNCHRONIZE_WHITELIST_ATTRIBUTES = %w[intern_process treatment_during_intern plan_after_intern].freeze

    def initialize(applicant, params, current_language)
      @other_language = Languagable.other_language(current_language)
      @current_language = current_language
      @params = permited params
      @applicant = applicant
    end

    def synchronize_data_between_all_languages(record)
      other_language_record = @applicant.experiences_confirmations.available
                                        .find_or_initialize_by(language: @other_language)
      not_updated_attributes = other_language_record.attributes.select { |_k, v| v.blank? }
                                                    .except(*SYNCHRONIZE_BLACKLIST_ATTRIBUTES).keys
      synchronization_data = record.slice(*not_updated_attributes, *SYNCHRONIZE_WHITELIST_ATTRIBUTES)
      other_language_record.assign_attributes synchronization_data

      if intern_process_content_changable?(other_language_record)
        other_language_record.intern_process_content = record.intern_process_content
      end

      other_language_record.save validate: false
    end

    private

    def permited(params)
      params.require(:applicant_experiences_confirmation)
            .permit(:id, :company_name, :department_name, :occupation_name, :creator_name,
                    :creator_position, :intern_process, :intern_process_content,
                    :treatment_during_intern, :treatment_during_intern_content, :plan_after_intern,
                    :plan_working_place, :plan_working_department, :plan_working_occupation)
    end

    def intern_process_content_changable?(record)
      record.expectation_after_interned_intern_process? || record.intern_process_was != record.intern_process
    end
  end
end
