# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |e|
      Rails.logger.error "**ERROR**: #{e.message}"

      e_message = I18n.t "notifications.errors.#{e.class.name.demodulize.underscore}",
                         default: I18n.t('notifications.errors.unknown')

      if request.format.js?
        flash.now[:error] = e_message
        render action_name
      elsif e.class == ActiveRecord::RecordInvalid
        model_name = e.record.class.name.underscore
        flash[:old_params] = request.request_parameters[model_name]
                                    .except(*Settings.image_params)
                                    .merge(is_submitted: true)
        redirect_to error_redirect_path, flash: {error: e_message}
      end
    end

    def render_page_with_record_invalid(render_page)
      flash.now[:error] = I18n.t('notifications.errors.record_invalid')
      render render_page
    end
  end

  private

  def error_redirect_path
    current_namespace = self.class.to_s.deconstantize == 'Staffs' ? 'manage' : 'supervise'
    default_path = send "#{current_namespace}_root_path"
    request.referer.presence || default_path
  end
end
