# frozen_string_literal: true

class JsonDataModel
  attr_accessor :data

  def initialize(klass, data = nil)
    @klass = klass
    @data = parse data
  end

  def validate!
    @data.each { |d| @valid = false unless d.valid? }
    @valid = true if @valid.nil?
  end

  def valid?
    validate! if @valid.nil?
    @valid
  end

  def exists_data?
    data.any?(&:exists_data?)
  end

  def valid_data?
    exists_data? && valid?
  end

  def invalid_data?
    exists_data? && !valid?
  end

  private

  def parse(data)
    parsed_json_data = JSON.parse data
    parsed_json_data.map { |d| @klass.new(d) }
  rescue StandardError
    @data = []
  end
end
