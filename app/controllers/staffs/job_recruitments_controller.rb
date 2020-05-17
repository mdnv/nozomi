# frozen_string_literal: true

module Staffs
  class JobRecruitmentsController < BaseController
    # before_action :authorized?, only: %i[index show]
    before_action :find_job_recruiment, only: %i[show edit update destroy]

    def index
      @q = ::JobRecruitment.ransack(params[:q])
      @job_recruitments = @q.result.available.includes(:company,
                                                       :supervising_organization,
                                                       :occupation).page params[:page]
    end
  end
end
