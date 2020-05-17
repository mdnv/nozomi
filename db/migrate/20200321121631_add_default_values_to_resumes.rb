class AddDefaultValuesToResumes < ActiveRecord::Migration[6.0]
  def change
    change_column :applicant_resumes, :relative_in_japan, :integer, limit: 1, default: 0
    change_column :applicant_resumes, :gone_to_japan, :integer, limit: 1, default: 0
    change_column :applicant_resumes, :passport, :integer, limit: 1, default: 0
    change_column :applicant_resumes, :tattoo, :integer, limit: 1, default: 0
  end
end
