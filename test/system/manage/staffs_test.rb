# frozen_string_literal: true

require 'application_system_test_case'

module Staffs
  class StaffsTest < ApplicationSystemTestCase
    setup do
      @administrator = staffs(:valid_administrator)
      @moderator = staffs(:valid_moderator)
      sign_in @administrator
      visit manage_staffs_url
    end

    # Access Page
    test 'visit the staffs list page' do
      assert_text I18n.t('views.titles.staffs.list')

      within 'table' do
        assert_selector 'td', count: 1, text: @administrator.username
        assert_selector 'td', count: 1, text: @moderator.username
      end
    end

    test 'visit staff detail page by click staff username on index page' do
      within 'table' do
        click_link @administrator.username
      end
      assert_current_path manage_staff_path(@administrator)
    end

    # INDEX: Filter form
    test 'filter by username on index page' do
      fill_in 'q[username_cont]', with: @administrator.username
      click_button I18n.t('views.actions.search')

      within 'table' do
        assert_selector 'td', count: 0, text: @moderator.username
        assert_selector 'td', count: 1, text: @administrator.username
      end
    end

    test 'filter by email on index page' do
      fill_in 'q[email_cont]', with: @moderator.email
      click_button I18n.t('views.actions.search')

      within 'table' do
        assert_selector 'td', count: 0, text: @administrator.email
        assert_selector 'td', count: 1, text: @moderator.email
      end
    end

    test 'filter by role on index page' do
      select Staff.human_attribute_name('role.moderator'), from: 'q[role_eq]'
      click_button I18n.t('views.actions.search')

      within 'table' do
        assert_selector 'td', count: 0, text: @administrator.email
        assert_selector 'td', count: 1, text: @moderator.email
      end
    end

    test 'filter by status active on index page' do
      select Staff.human_attribute_name('status.active'), from: 'q[status_eq]'
      click_button I18n.t('views.actions.search')

      within 'table' do
        assert_selector 'td', count: 1, text: @administrator.email
        assert_selector 'td', count: 1, text: @moderator.email
      end
    end

    test 'filter by status disactive on index page' do
      select Staff.human_attribute_name('status.disactive'), from: 'q[status_eq]'
      click_button I18n.t('views.actions.search')
      assert_text I18n.t('announcements.no_record')
    end

    test 'filter by created at on index page' do
      # Searched data
      fill_in 'q[created_at_gteq]', with: I18n.l(Time.zone.now + 1.day, format: :date_only)
      click_button I18n.t('views.actions.search')
      assert_text I18n.t('announcements.no_record')

      # Searched no data
      fill_in 'q[created_at_gteq]', with: I18n.l(Time.zone.now - 1.day, format: :date_only)
      click_button I18n.t('views.actions.search')
      within 'table' do
        assert_selector 'td', count: 1, text: @administrator.email
      end
    end

    # Belongs To Permission
    test 'staff can only edit his self or her self' do
      # Only current staff has link to edit page
      within 'table' do
        assert_selector :link, href: edit_manage_staff_path(@administrator), count: 1
        assert_selector :link, href: edit_manage_staff_path(@moderator), count: 0
      end

      # Can access to self edit page
      visit edit_manage_staff_url(@administrator)
      assert_current_path edit_manage_staff_path(@administrator)

      # Can not access to edit page of other staff
      visit edit_manage_staff_url(@moderator)
      assert_no_current_path edit_manage_staff_path(@moderator)
      assert_text I18n.t('notifications.errors.not_authorized_error')
    end
  end
end
