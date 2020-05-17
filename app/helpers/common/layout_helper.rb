# frozen_string_literal: true

module Common
  module LayoutHelper
    def sidebar_active?(item)
      controller_name == item[:controller]
    end

    def breadcrumbs(items)
      items = {home: manage_root_path}.merge items
      content_for :breadcrumbs, render('layouts/sharing/breadcrumb', items: items)
    end

    def navigation_item_name(name)
      return t('views.labels.undefined') if name.blank?

      t "views.navigation_items.#{name}", default: name
    end
  end
end
