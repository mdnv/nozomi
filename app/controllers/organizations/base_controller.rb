# frozen_string_literal: true

module Organizations
  class BaseController < ApplicationController
    before_action :authenticate_supervising_organization!

    include Pundit
    include BeforeRender
    include ErrorHandler
    layout ->(c) { c.request.xhr? ? false : 'organizations' }

    protected

    def policy_scope(scope)
      super [:organizations, scope]
    end

    def authorize(record, query = nil)
      super [:organizations, record], query
    end

    def pundit_user
      current_organization
    end

    def authorized?
      authorize controller_name.classify.constantize
    end
  end
end
