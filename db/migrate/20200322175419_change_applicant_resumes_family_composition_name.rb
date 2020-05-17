class ChangeApplicantResumesFamilyCompositionName < ActiveRecord::Migration[6.0]
  def change
    rename_column :applicant_resumes, :family_composition, :family_composition_json
  end
end
