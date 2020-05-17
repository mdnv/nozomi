# frozen_string_literal: true

module Staffs
  module Applicants
    module ResumesHelper
      def blood_types_for_checkboxes
        Applicant::Resume.blood_types.map do |type, _value|
          [type, t("nested_attributes.blood_types.#{type}", locale: current_language)]
        end
      end

      def forehands_for_checkboxes
        Applicant::Resume.forehands.map do |name, _v|
          [name, t("nested_attributes.forehands.#{name}", locale: current_language)]
        end
      end

      def tattoos_for_checkboxes
        Applicant::Resume.tattoos.map do |name, _v|
          [name, t("nested_attributes.true_false.#{name}", locale: current_language)]
        end
      end

      def marital_statuses_for_checkboxes
        Applicant::Resume.marital_statuses.map do |name, _v|
          [name, t("nested_attributes.marital_statuses.#{name}", locale: current_language)]
        end
      end

      def passports_for_checkboxes
        Applicant::Resume.passports.map do |name, _v|
          [name, t("nested_attributes.true_false.#{name}", locale: current_language)]
        end
      end
    end
  end
end
