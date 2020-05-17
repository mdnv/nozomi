# frozen_string_literal: true

module Api
  module V1
    module Secure
      class SupervisingOrganizationsController < SecureApiController
        before_action :find_supervising_organization

        def available_company_ids
          @company_ids = @supervising_organization.companies.available.ids
        end

        private

        def find_supervising_organization
          @supervising_organization = SupervisingOrganization.find params[:id]
        end
      end
    end
  end
end
