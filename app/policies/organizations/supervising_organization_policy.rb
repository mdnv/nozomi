# frozen_string_literal: true

module Organizations
  class SupervisingOrganizationPolicy < ApplicationPolicy
    attr_reader :current_supervising_organization, :supervising_organization

    def initialize(current_supervising_organization, supervising_organization)
      @current_supervising_organization = current_supervising_organization
      @upervising_organization = supervising_organization
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?
      current_supervising_organization.administrator? &&
        current_supervising_organization.active? &&
        create_lower_or_equal_self_role?
    end

    def new?
      create?
    end

    def edit?
      current_supervising_organization.eql?(supervising_organization)
    end

    def update?
      edit? && not_upgrade_role? && not_set_active_by_self?
    end
  end
end
