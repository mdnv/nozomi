# frozen_string_literal: true

module Helpers
  module YearMonthValidatorHelper
    def self.year_greater_than_or_equal_to(record)
      from_year = record.from_year.to_i
      return from_year if (Settings.minimum_year..Date.current.year).include? from_year

      Settings.minimum_year
    end

    def self.month_greater_than_or_equal_to(record)
      from_year = record.from_year.to_i
      to_year = record.to_year.to_i
      from_month = record.from_month.to_i
      return 1 if from_year < to_year

      (1..12).include?(from_month) ? from_month : 1
    end
  end
end
