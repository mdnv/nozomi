class ChangeExaminationResultsMarkFromIntegerToString < ActiveRecord::Migration[6.0]
  def change
    change_column :examination_results, :mark, :string
  end
end
