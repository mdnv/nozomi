class ChangeMarkFieldsTypes < ActiveRecord::Migration[6.0]
  def change
    change_column :studying_results, :mark, :float, precision: 5, scale: 2, default: 0
    change_column :examination_results, :mark, :float, precision: 5, scale: 2, default: 0
  end
end
