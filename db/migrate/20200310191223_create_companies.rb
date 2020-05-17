class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.belongs_to :supervising_organization
      t.string     :vi_name
      t.string     :ja_name
      t.string     :ceo_name
      t.string     :address
      t.string     :tel

      ## Logical delete
      t.integer  :availability,         limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
