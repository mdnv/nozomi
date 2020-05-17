class CreateApplicantResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_resumes do |t|
      t.belongs_to :applicant
      t.integer    :language, limit: 1, default: 0

      t.string :permanent_residence_address
      t.string :family_tel

      t.integer :blood_type,     limit: 1
      t.integer :forehand,       limit: 1
      t.integer :marital_status, limit: 1
      t.integer :tattoo,         limit: 1
      t.float   :height
      t.float   :weight
      t.float   :left_eyesight
      t.float   :right_eyesight

      t.text :hobbies
      t.text :strong_points
      t.text :weak_points
      t.text :family_composition
      t.text :learning_histories
      t.text :working_histories
      t.text :expectation_after_work
      t.text :goals_after_returned
      t.text :long_term_goals

      t.integer  :passport, limit: 1
      t.string   :passport_number
      t.datetime :passport_issued_at

      t.integer :gone_to_japan,     limit: 1
      t.string  :gone_reason

      t.integer :relative_in_japan, limit: 1
      t.string  :relative_fullname
      t.string  :relative_relationship

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
