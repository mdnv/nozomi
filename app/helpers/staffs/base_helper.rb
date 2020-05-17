# frozen_string_literal: true

module Staffs
  module BaseHelper
    include Common::NotificationsHelper
    include Common::ParamsHelper
    include Common::LayoutHelper
    include Common::RecordHelper
    include Common::FormsHelper
    include Common::LanguageHelper

    def can(*policy_scope)
      policy([:staffs, *policy_scope])
    end
  end
end
