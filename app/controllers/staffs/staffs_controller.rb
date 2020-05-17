# frozen_string_literal: true

module Staffs
  class StaffsController < BaseController
    before_action :authorized?, only: %i[index show]
    before_action :find_staff, only: %i[show edit update destroy]

    def index
      @q = Staff.ransack params[:q]
      @staffs = @q.result.available.includes(:department).page params[:page]
    end

    def new
      @staff = Staff.new flash[:old_params]
    end

    def create
      @staff = Staff.create! create_params
      redirect_to manage_staff_path(@staff),
                  flash: {success: I18n.t('notifications.create_staff_successfully')}
    end

    def edit; end

    def destroy
      @staff.destroy
      redirect_to manage_staff_path(@staff),
                  flash: {success: I18n.t('notifications.delete_staff_successfully')}
    end

    def update
      @staff.update! update_params
      redirect_to manage_staff_path(@staff),
                  flash: {success: I18n.t('notifications.update_staff_successfully')}
    end

    private

    def find_staff
      @staff = Staff.find(params[:id])
    end

    def create_params
      params.require(:staff)
            .permit(:username, :email, :password, :password_confirmation,
                    :department_id, :address, :birthdate, :hometown, :phone)
    end

    def update_params
      params.require(:staff)
            .permit(:username, :slug, :email, :password, :password_confirmation,
                    :department_id, :address, :birthdate, :hometown, :phone)
    end
  end
end
