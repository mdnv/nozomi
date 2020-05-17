# frozen_string_literal: true

module Organizations
  module BaseHelper
    include Common::NotificationsHelper
    include Common::ParamsHelper
    include Common::LayoutHelper
    include Common::RecordHelper

    def can(policy_scope)
      policy([:organizations, policy_scope])
    end
  end
end
