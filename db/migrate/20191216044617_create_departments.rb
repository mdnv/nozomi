class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string   :vi_name
      t.string   :ja_name
      t.text     :description

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
