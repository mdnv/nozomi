# frozen_string_literal: true

class DateRangeValidator < ActiveModel::EachValidator
  AVAILABLE_OPTIONS = %i[between greater_than_or_equal_to less_than_or_equal_to greater_than less_than].freeze

  def validate_each(record, attribute, value)
    options.slice(*AVAILABLE_OPTIONS).keys.each do |rule|
      send("validate_#{rule}", record, attribute, value, options[rule])
    end
  end

  private

  def validate_between(record, attribute, value, data)
    return if value && (data.first <= value) && (data.last >= value)

    default_message = I18n.t('errors.messages.not_in_date_range', from: date_only(data.first),
                                                                  to: date_only(data.last))
    record.errors[attribute] << (options[:message] || default_message)
  end

  def validate_greater_than_or_equal_to(record, attribute, value, data)
    return if value && value >= data

    default_message = I18n.t('errors.messages.greater_than_or_equal_to_date', date: date_only(data))
    record.errors[attribute] << (options[:message] || default_message)
  end

  def validate_less_than_or_equal_to(record, attribute, value, data)
    return if value && value <= data

    default_message = I18n.t('errors.messages.less_than_or_equal_to_date', date: date_only(data))
    record.errors[attribute] << (options[:message] || default_message)
  end

  def validate_greater_than(record, attribute, value, data)
    return if value && value > data

    default_message = I18n.t('errors.messages.greater_than', date: date_only(data))
    record.errors[attribute] << (options[:message] || default_message)
  end

  def validate_less_than(record, attribute, value, data)
    return if value && value < data

    default_message = I18n.t('errors.messages.less_than', date: date_only(data))
    record.errors[attribute] << (options[:message] || default_message)
  end

  def date_only(date)
    I18n.l(date, format: :date_only, default: nil)
  end
end
