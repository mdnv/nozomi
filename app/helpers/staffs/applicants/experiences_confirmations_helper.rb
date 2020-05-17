# frozen_string_literal: true

module Staffs
  module Applicants
    module ExperiencesConfirmationsHelper
      def intern_process_content_enterable?(type_name)
        %w[recommended other].include? type_name
      end

      def keep_relationship_with_intern_options?(type_name)
        %w[keep_working leave_from_work].include? type_name
      end

      def treatment_during_intern_content_enterable?(type_name)
        type_name == 'other'
      end

      def back_after_intern?(type_name)
        type_name == 'back'
      end

      def intern_processes_for_radio_group
        Applicant::ExperiencesConfirmation.intern_processes.keys.map do |w|
          [
            w,
            Applicant::ExperiencesConfirmation.human_attribute_name("intern_process.#{w}",
                                                                    locale: current_language)
          ]
        end
      end

      def intern_treatment_during_interns_for_radio_group
        Applicant::ExperiencesConfirmation.treatment_during_interns.keys.map do |w|
          [
            w,
            Applicant::ExperiencesConfirmation.human_attribute_name("treatment_during_interns.#{w}",
                                                                    locale: current_language)
          ]
        end
      end

      def plan_after_interns_for_radio_group
        Applicant::ExperiencesConfirmation.plan_after_interns.keys.map do |w|
          [
            w,
            Applicant::ExperiencesConfirmation.human_attribute_name("plan_after_interns.#{w}",
                                                                    locale: current_language)
          ]
        end
      end
    end
  end
end
