# frozen_string_literal: true

module Languagable
  extend ActiveSupport::Concern

  AVAILABLE_LANGUAGES = {vi: 0, ja: 1}.freeze

  included do
    enum language: AVAILABLE_LANGUAGES, _suffix: true

    def other_language(name = language)
      Languagable.other_language(name)
    end
  end

  def self.other_language(language)
    language.to_s == 'ja' ? 'vi' : 'ja'
  end
end
