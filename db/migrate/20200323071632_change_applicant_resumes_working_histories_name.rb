class ChangeApplicantResumesWorkingHistoriesName < ActiveRecord::Migration[6.0]
  def change
    rename_column :applicant_resumes, :working_histories, :working_histories_json
  end
end
