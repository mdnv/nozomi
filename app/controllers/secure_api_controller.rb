# frozen_string_literal: true

class SecureApiController < ActionController::API
  before_action :authenticate_staff!
end
