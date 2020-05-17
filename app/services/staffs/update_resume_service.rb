# frozen_string_literal: true

module Staffs
  class UpdateResumeService
    attr_accessor :params

    SYNCHRONIZE_BLACKLIST_ATTRIBUTES = %w[deleted_at id].freeze
    SYNCHRONIZE_WHITELIST_ATTRIBUTES = %w[family_tel blood_type forehand tattoo height weight
                                          marital_status left_eyesight right_eyesight passport
                                          passport passport_number passport_issued_at relative_in_japan].freeze
    JSON_ATTRIBUTES = %w[family_composition_json learning_histories_json working_histories_json].freeze

    def initialize(applicant, params, current_language)
      params[:applicant_resume][:family_composition_json] = get_family_composition(params)
      params[:applicant_resume][:learning_histories_json] = get_learning_histories(params)
      params[:applicant_resume][:working_histories_json] = get_working_histories(params)
      @other_language = Languagable.other_language(current_language)
      @current_language = current_language
      @params = permited params
      @applicant = applicant
    end

    def create_other_language_resume_if_not_exists
      resume = @applicant.resumes.find_or_initialize_by(language: @other_language)
      resume.assign_attributes @params
      resume.save validate: false
    end

    def synchronize_data_between_all_languages(record)
      other_language_record = @applicant.resumes.available.find_or_initialize_by(language: @other_language)
      not_updated_attributes = other_language_record.attributes.select { |k, v| available_to_sync?(k, v) }
                                                    .except(*SYNCHRONIZE_BLACKLIST_ATTRIBUTES).keys
      synchronization_data = record.slice(*not_updated_attributes, *SYNCHRONIZE_WHITELIST_ATTRIBUTES)
      other_language_record.assign_attributes synchronization_data
      other_language_record.save validate: false
    end

    private

    def get_data(params, *attributes)
      params[attributes.first].map.with_index do |_value, index|
        data = {}
        attributes.each { |attribute| data[attribute] = params.dig(attribute, index) }
        data if data.any? { |_k, v| v.present? }
      end.compact
    end

    def available_to_sync?(key, value)
      return true if value.blank?

      JSON_ATTRIBUTES.include?(key) && JSON.parse(value).empty?
    end

    def get_family_composition(params)
      get_data(params[:family_composition], :fullname, :relationship, :age, :phone_number, :occupation, :income).to_json
    end

    def get_learning_histories(params)
      get_data(params[:learning_histories], :from_year, :to_year, :from_month, :to_month, :school, :major).to_json
    end

    def get_working_histories(params)
      get_data(params[:working_histories], :from_year, :to_year,
               :from_month, :to_month, :company_name, :job_scope, :income).to_json
    end

    def permited(params)
      params.require(:applicant_resume)
            .permit :id, :permanent_place_of_residence, :family_tel, :height, :weight, :hobbies,
                    :left_eyesight, :right_eyesight, :blood_type, :forehand, :tattoo, :marital_status,
                    :strong_points, :expectation_after_work, :goals_after_returned, :long_term_goals,
                    :passport, :passport_number, :passport_issued_at, :gone_to_japan, :gone_reason,
                    :relative_in_japan, :relative_fullname, :relative_relationship, :family_composition_json,
                    :learning_histories_json, :working_histories_json
    end
  end
end
