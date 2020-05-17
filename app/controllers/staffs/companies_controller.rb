# frozen_string_literal: true

module Staffs
  class CompaniesController < BaseController
    # before_action :authorized?, only: %i[index show]
    before_action :find_companies, only: %i[show edit update destroy]

    def index
      @q = Company.ransack(params[:q])
      @companies = @q.result.available.includes(:supervising_organization).page params[:page]
    end
  end
end
