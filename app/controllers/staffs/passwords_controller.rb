# frozen_string_literal: true

module Staffs
  class PasswordsController < Devise::PasswordsController
    layout 'authentication'
  end
end
