class CreateApplicantExperiencesConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_experiences_confirmations do |t|
      t.belongs_to :applicant
      t.integer    :language, limit: 1, default: 0

      t.string :company_name
      t.string :department_name
      t.string :occupation_name
      t.string :creator_name
      t.string :creator_position

      t.integer :intern_process, limit: 1
      t.string :intern_process_nominate_reason
      t.string  :intern_process_content

      t.integer :treatment_during_intern, limit: 1
      t.string  :treatment_content_during_intern

      t.integer :plan_after_intern, limit: 1
      t.string  :plan_working_place

      t.string :plan_working_department
      t.string :plan_working_occupation

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
