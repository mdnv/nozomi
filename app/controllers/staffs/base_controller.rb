# frozen_string_literal: true

module Staffs
  class BaseController < ApplicationController
    before_action :authenticate_staff!

    include Pundit
    include BeforeRender
    include ErrorHandler
    include Common::LanguageHelper
    layout ->(c) { c.request.xhr? ? false : 'staffs' }

    helper_method :current_language

    protected

    def policy_scope(scope)
      super [:staffs, scope]
    end

    def authorize(record, query = nil)
      super [:staffs, record], query
    end

    def pundit_user
      current_staff
    end

    def authorized?
      authorize controller_name.classify.constantize
    end

    def query_params
      query = params[:q] || {}
      query.each { |_k, v| v.strip! unless v.is_a?(Array) }
    end
  end
end
