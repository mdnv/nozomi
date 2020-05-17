class CreateApplicantVisaInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_visa_informations do |t|
      t.belongs_to :applicant
      t.integer    :language, limit: 1, default: 0

      t.string :nationality
      t.string :other_nationality
      t.string :id_no

      t.integer  :passport_type, limit: 1
      t.string   :passport_no
      t.string   :place_of_issue
      t.string   :issuing_authority
      t.datetime :date_of_issue
      t.datetime :date_of_expiry

      t.string   :purpose_of_visiting
      t.string   :intended_length_of_staying
      t.string   :port_of_entry
      t.string   :name_of_ship_or_airline
      t.string   :hotel_name
      t.string   :hotel_address
      t.string   :hotel_tel
      t.datetime :date_of_arrival

      t.string :date_and_duration_of_previous_staying
      t.string :current_residential_address
      t.string :current_tel
      t.string :current_mobile_no
      t.string :current_email
      t.string :current_job_and_possition
      t.string :current_company_name
      t.string :current_company_address
      t.string :current_company_tel

      t.string :partner_job

      t.string   :guarantor_name
      t.string   :guarantor_tel
      t.string   :guarantor_address
      t.string   :guarantor_relationship
      t.string   :guarantor_job_and_position
      t.string   :guarantor_nationality_and_immigration_status
      t.integer  :guarantor_gender, limit: 1
      t.datetime :guarantor_birthday

      t.string   :inviter_name
      t.string   :inviter_tel
      t.string   :inviter_address
      t.string   :inviter_relationship
      t.string   :inviter_job_and_position
      t.string   :inviter_nationality_and_immigration_status
      t.integer  :inviter_gender, limit: 1
      t.datetime :inviter_birthday

      t.string :remarks_or_special_circumstances

      t.integer  :question_1, limit: 1
      t.integer  :question_2, limit: 1
      t.integer  :question_3, limit: 1
      t.integer  :question_4, limit: 1
      t.integer  :question_5, limit: 1
      t.integer  :question_6, limit: 1
      t.integer  :question_7, limit: 1
      t.integer  :question_8, limit: 1
      t.integer  :question_9, limit: 1
      t.text     :detail_answers_of_questions

      t.datetime :date_of_application

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
