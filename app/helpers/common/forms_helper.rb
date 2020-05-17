# frozen_string_literal: true

module Common
  module FormsHelper
    def hometowns_for_select
      Regions::VIETNAM.map { |name| [I18n.t("regions.#{name}", locale: current_language), name] }
    end

    def genders_for_select
      Genderable::GENDERS.map { |name, _v| [t("nested_attributes.gender.#{name}"), name] }
    end

    def genders_for_select_search
      Genderable::GENDERS.map { |name, value| [Applicant.human_attribute_name("gender.#{name}"), value] }
    end

    def genders_for_radio_group
      Genderable::GENDERS.map { |name, _v| [name, t("nested_attributes.genders.#{name}", locale: current_language)] }
    end

    def options_has_or_has_not_for_checkboxes
      [
        [:has_not, I18n.t('nested_attributes.true_false.has_not', locale: current_language)],
        [:has, I18n.t('nested_attributes.true_false.has', locale: current_language)]
      ]
    end

    def languages_for_select
      Languagable::AVAILABLE_LANGUAGES.keys.map do |name|
        [t("nested_attributes.languages.#{name}", locale: current_language), name]
      end
    end
  end
end
