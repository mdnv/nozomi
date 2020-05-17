class CreateStudyingResults < ActiveRecord::Migration[6.0]
  def change
    create_table :studying_results do |t|
      t.belongs_to :job_recruitment_applicant
      t.belongs_to :job_recruitment
      t.belongs_to :applicant

      t.string     :subject
      t.string     :mark
      t.datetime   :started_at

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
