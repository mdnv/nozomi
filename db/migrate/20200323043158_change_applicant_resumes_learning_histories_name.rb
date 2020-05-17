class ChangeApplicantResumesLearningHistoriesName < ActiveRecord::Migration[6.0]
  def change
    rename_column :applicant_resumes, :learning_histories, :learning_histories_json
  end
end
