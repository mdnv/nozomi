# frozen_string_literal: true

module Staffs
  class SupervisingOrganizationsController < BaseController
    before_action :authorized?, only: %i[index show]
    before_action :find_supervisingorganization, only: %i[show edit update destroy]

    def index
      @q = SupervisingOrganization.ransack params[:q]
      @supervisingorganizations = @q.result.page params[:page]
    end

    def new
      @supervisingorganization = SupervisingOrganization.new flash[:old_params]
    end

    def create
      @supervisingorganization = SupervisingOrganization.create! create_params
      redirect_to manage_supervising_organizations_path(@supervisingorganization),
                  flash: {success: I18n.t('notifications.create_staff_successfully')}
    end

    def edit; end

    def destroy
      @supervisingorganization.destroy
      redirect_to manage_supervising_organization_path(@supervisingorganization),
                  flash: {success: I18n.t('notifications.delete_staff_successfully')}
    end

    def update
      @supervisingorganization.update! update_params
      redirect_to manage_supervising_organization_path(@supervisingorganization),
                  flash: {success: I18n.t('notifications.update_staff_successfully')}
    end

    private

    def find_supervisingorganization
      @supervisingorganization = ::SupervisingOrganization.find(params[:id])
    end

    def create_params
      params.require(:supervising_organization)
            .permit(:username, :email, :password, :password_confirmation, :vi_name, :ja_name,
                    :address, :tel, :ceo_name)
    end

    def update_params
      params.require(:supervising_organization)
            .permit(:username, :email, :password, :password_confirmation, :vi_name, :ja_name,
                    :address, :tel, :ceo_name)
    end
  end
end
