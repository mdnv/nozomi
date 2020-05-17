# frozen_string_literal: true

module Staffs
  class SupervisingOrganizationPolicy < ApplicationPolicy
    attr_reader :current_supervising_origanization, :supervising_origanization

    def initialize(current_supervising_origanization, supervising_origanization)
      @current_supervising_origanization = current_supervising_origanization
      @supervising_origanization = supervising_origanization
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?; end

    def new?; end

    def edit?; end

    def update?; end
  end
end
