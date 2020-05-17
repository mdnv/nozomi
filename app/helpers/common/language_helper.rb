# frozen_string_literal: true

module Common
  module LanguageHelper
    def current_language
      if Languagable::AVAILABLE_LANGUAGES.key? params[:language]&.to_sym
        params[:language]
      else
        I18n.locale
      end
    end

    def current_language?(name)
      current_language.to_s == name.to_s
    end
  end
end
