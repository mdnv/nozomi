class RenameApplicantExperiencesConfirmationsTreatmentContentDuringIntern < ActiveRecord::Migration[6.0]
  def change
    rename_column :applicant_experiences_confirmations, :treatment_content_during_intern, :treatment_during_intern_content
  end
end
