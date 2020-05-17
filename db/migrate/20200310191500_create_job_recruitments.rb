class CreateJobRecruitments < ActiveRecord::Migration[6.0]
  def change
    create_table :job_recruitments do |t|
      t.belongs_to :supervising_organization
      t.belongs_to :company
      t.belongs_to :occupation

      # Basic informations
      t.string   :training_allowance
      t.string   :woking_schedule
      t.string   :overtime_schedule
      t.string   :breaktime
      t.string   :working_date
      t.string   :amount_woking_applicants

      t.integer  :basic_salary
      t.integer  :net_salary
      t.string   :overtime_salary_per_hour

      # Interview Plans
      t.datetime :entering_form_at
      t.datetime :assigning_ended_at
      t.datetime :examination_started_at
      t.string   :examination_way
      t.string   :examination_content
      t.string   :examination_organized_place
      t.integer  :amount_of_participation

      # Requirements
      t.string   :genders
      t.string   :age_range

      t.float    :height_from
      t.float    :height_to
      t.float    :weight_from
      t.float    :weight_to

      t.string   :blood_type
      t.string   :educational

      t.integer  :forehand,       limit: 1
      t.integer  :marital_status, limit: 1
      t.integer  :smoking,        limit: 1
      t.integer  :drink_alcohol,  limit: 1
      t.integer  :eyesight,       limit: 1
      t.integer  :tattoo,         limit: 1
      t.integer  :experience,     limit: 1
      t.datetime :expected_emigrate_at
      t.string   :contract_expires_in
      t.text     :job_scope

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
