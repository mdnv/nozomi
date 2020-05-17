class ChangeApplicantResumePermanentResidenceAddressColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :applicant_resumes, :permanent_residence_address, :permanent_place_of_residence
  end
end
