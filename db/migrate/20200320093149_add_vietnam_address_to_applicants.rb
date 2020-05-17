class AddVietnamAddressToApplicants < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :vietnam_address, :string, after: :vietnam_phone_number
  end
end
