class CreateDepartmentPages < ActiveRecord::Migration[6.0]
  def change
    create_table :department_pages do |t|
      t.belongs_to :department
      t.string     :controller_name
      t.string     :action_name
      t.integer    :status, limit: 1, default: 1
      t.timestamps
    end
  end
end
