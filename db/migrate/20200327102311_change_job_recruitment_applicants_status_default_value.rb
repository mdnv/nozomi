class ChangeJobRecruitmentApplicantsStatusDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :job_recruitment_applicants, :status, nil
  end
end
