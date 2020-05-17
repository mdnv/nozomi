class CreateJobRecruitmentApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :job_recruitment_applicants do |t|
      t.belongs_to :job_recruitment
      t.belongs_to :applicant

      t.integer  :status,       limit: 1, default: 0

      t.datetime :passed_examination_at
      t.datetime :expected_immigrate_at
      t.datetime :emigrated_at
      t.datetime :immigrated_at

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
