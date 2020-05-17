class CreateInternTrainingPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :intern_training_payments do |t|
      t.belongs_to :job_recruitment
      t.belongs_to :applicant
      t.integer    :language, limit: 1, default: 0

      t.string  :currency_type
      t.float   :exchange_rate

      t.string :company_name
      t.string :organization_name
      t.string :supervisory_authority_name
      t.string :creator_name
      t.string :creator_position

      t.text :paid_local_company_costs
      t.text :paid_foreign_company_costs

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
