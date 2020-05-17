# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_28_194633) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "applicant_experiences_confirmations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "applicant_id"
    t.integer "language", limit: 1, default: 0
    t.string "company_name"
    t.string "department_name"
    t.string "occupation_name"
    t.string "creator_name"
    t.string "creator_position"
    t.integer "intern_process", limit: 1
    t.string "intern_process_content"
    t.integer "treatment_during_intern", limit: 1
    t.string "treatment_during_intern_content"
    t.integer "plan_after_intern", limit: 1
    t.string "plan_working_place"
    t.string "plan_working_department"
    t.string "plan_working_occupation"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_applicant_experiences_confirmations_on_applicant_id"
  end

  create_table "applicant_resumes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "applicant_id"
    t.integer "language", limit: 1, default: 0
    t.string "permanent_place_of_residence"
    t.string "family_tel"
    t.integer "blood_type", limit: 1
    t.integer "forehand", limit: 1
    t.integer "marital_status", limit: 1
    t.integer "tattoo", limit: 1, default: 0
    t.float "height"
    t.float "weight"
    t.float "left_eyesight"
    t.float "right_eyesight"
    t.text "hobbies"
    t.text "strong_points"
    t.text "weak_points"
    t.text "family_composition_json"
    t.text "learning_histories_json"
    t.text "working_histories_json"
    t.text "expectation_after_work"
    t.text "goals_after_returned"
    t.text "long_term_goals"
    t.integer "passport", limit: 1, default: 0
    t.string "passport_number"
    t.datetime "passport_issued_at"
    t.integer "gone_to_japan", limit: 1, default: 0
    t.string "gone_reason"
    t.integer "relative_in_japan", limit: 1, default: 0
    t.string "relative_fullname"
    t.string "relative_relationship"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_applicant_resumes_on_applicant_id"
  end

  create_table "applicant_visa_informations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "applicant_id"
    t.integer "language", limit: 1, default: 0
    t.string "nationality"
    t.string "other_nationality"
    t.string "id_no"
    t.integer "passport_type", limit: 1
    t.string "passport_no"
    t.string "place_of_issue"
    t.string "issuing_authority"
    t.datetime "date_of_issue"
    t.datetime "date_of_expiry"
    t.string "purpose_of_visiting"
    t.string "intended_length_of_staying"
    t.string "port_of_entry"
    t.string "name_of_ship_or_airline"
    t.string "hotel_name"
    t.string "hotel_address"
    t.string "hotel_tel"
    t.datetime "date_of_arrival"
    t.string "date_and_duration_of_previous_staying"
    t.string "current_residential_address"
    t.string "current_tel"
    t.string "current_mobile_no"
    t.string "current_email"
    t.string "current_job_and_possition"
    t.string "current_company_name"
    t.string "current_company_address"
    t.string "current_company_tel"
    t.string "partner_job"
    t.string "guarantor_name"
    t.string "guarantor_tel"
    t.string "guarantor_address"
    t.string "guarantor_relationship"
    t.string "guarantor_job_and_position"
    t.string "guarantor_nationality_and_immigration_status"
    t.integer "guarantor_gender", limit: 1
    t.datetime "guarantor_birthday"
    t.string "inviter_name"
    t.string "inviter_tel"
    t.string "inviter_address"
    t.string "inviter_relationship"
    t.string "inviter_job_and_position"
    t.string "inviter_nationality_and_immigration_status"
    t.integer "inviter_gender", limit: 1
    t.datetime "inviter_birthday"
    t.string "remarks_or_special_circumstances"
    t.integer "question_1", limit: 1
    t.integer "question_2", limit: 1
    t.integer "question_3", limit: 1
    t.integer "question_4", limit: 1
    t.integer "question_5", limit: 1
    t.integer "question_6", limit: 1
    t.integer "question_7", limit: 1
    t.integer "question_8", limit: 1
    t.integer "question_9", limit: 1
    t.text "detail_answers_of_questions"
    t.datetime "date_of_application"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_applicant_visa_informations_on_applicant_id"
  end

  create_table "applicants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "firstname"
    t.string "lastname"
    t.string "fullname"
    t.string "fullname_katakana"
    t.string "fullname_kanji"
    t.string "other_name"
    t.integer "gender", limit: 1, default: 0
    t.datetime "birthdate"
    t.string "birthplace"
    t.string "hometown"
    t.string "vietnam_phone_number"
    t.string "vietnam_address"
    t.string "japan_phone_number"
    t.string "japan_address"
    t.text "personal_note"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_applicants_on_creator_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "supervising_organization_id"
    t.string "vi_name"
    t.string "ja_name"
    t.string "ceo_name"
    t.string "address"
    t.string "tel"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supervising_organization_id"], name: "index_companies_on_supervising_organization_id"
  end

  create_table "department_pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "department_id"
    t.string "controller_name"
    t.string "action_name"
    t.integer "status", limit: 1, default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_department_pages_on_department_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "vi_name"
    t.string "ja_name"
    t.text "description"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "examination_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_recruitment_applicant_id"
    t.bigint "job_recruitment_id"
    t.bigint "applicant_id"
    t.string "subject"
    t.float "mark", default: 0.0
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_examination_results_on_applicant_id"
    t.index ["job_recruitment_applicant_id"], name: "index_examination_results_on_job_recruitment_applicant_id"
    t.index ["job_recruitment_id"], name: "index_examination_results_on_job_recruitment_id"
  end

  create_table "intern_training_payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_recruitment_id"
    t.bigint "applicant_id"
    t.integer "language", limit: 1, default: 0
    t.string "currency_type"
    t.float "exchange_rate"
    t.string "company_name"
    t.string "organization_name"
    t.string "supervisory_authority_name"
    t.string "creator_name"
    t.string "creator_position"
    t.text "paid_local_company_costs"
    t.text "paid_foreign_company_costs"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_intern_training_payments_on_applicant_id"
    t.index ["job_recruitment_id"], name: "index_intern_training_payments_on_job_recruitment_id"
  end

  create_table "job_recruitment_applicants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_recruitment_id"
    t.bigint "applicant_id"
    t.integer "status", limit: 1
    t.datetime "passed_examination_at"
    t.datetime "expected_immigrate_at"
    t.datetime "emigrated_at"
    t.datetime "immigrated_at"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_job_recruitment_applicants_on_applicant_id"
    t.index ["job_recruitment_id"], name: "index_job_recruitment_applicants_on_job_recruitment_id"
  end

  create_table "job_recruitments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "supervising_organization_id"
    t.bigint "company_id"
    t.bigint "occupation_id"
    t.string "training_allowance"
    t.string "woking_schedule"
    t.string "overtime_schedule"
    t.string "breaktime"
    t.string "working_date"
    t.string "amount_woking_applicants"
    t.integer "basic_salary"
    t.integer "net_salary"
    t.string "overtime_salary_per_hour"
    t.datetime "entering_form_at"
    t.datetime "assigning_ended_at"
    t.datetime "examination_started_at"
    t.string "examination_way"
    t.string "examination_content"
    t.string "examination_organized_place"
    t.integer "amount_of_participation"
    t.string "genders"
    t.string "age_range"
    t.float "height_from"
    t.float "height_to"
    t.float "weight_from"
    t.float "weight_to"
    t.string "blood_type"
    t.string "educational"
    t.integer "forehand", limit: 1
    t.integer "marital_status", limit: 1
    t.integer "smoking", limit: 1
    t.integer "drink_alcohol", limit: 1
    t.integer "eyesight", limit: 1
    t.integer "tattoo", limit: 1
    t.integer "experience", limit: 1
    t.datetime "expected_emigrate_at"
    t.string "contract_expires_in"
    t.text "job_scope"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_job_recruitments_on_company_id"
    t.index ["occupation_id"], name: "index_job_recruitments_on_occupation_id"
    t.index ["supervising_organization_id"], name: "index_job_recruitments_on_supervising_organization_id"
  end

  create_table "occupations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "vi_name"
    t.string "ja_name"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "staffs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", limit: 1, default: 0
    t.integer "status", limit: 1, default: 1
    t.string "address"
    t.datetime "birthdate"
    t.string "hometown"
    t.string "phone"
    t.bigint "department_id"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_staffs_on_department_id"
    t.index ["email"], name: "index_staffs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
  end

  create_table "studying_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "job_recruitment_applicant_id"
    t.bigint "job_recruitment_id"
    t.bigint "applicant_id"
    t.string "subject"
    t.float "mark", default: 0.0
    t.datetime "started_at"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_studying_results_on_applicant_id"
    t.index ["job_recruitment_applicant_id"], name: "index_studying_results_on_job_recruitment_applicant_id"
    t.index ["job_recruitment_id"], name: "index_studying_results_on_job_recruitment_id"
  end

  create_table "supervising_organizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "status", limit: 1, default: 1
    t.string "vi_name"
    t.string "ja_name"
    t.string "address"
    t.string "tel"
    t.string "ceo_name"
    t.integer "availability", limit: 1, default: 1
    t.datetime "deleted_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_supervising_organizations_on_email", unique: true
    t.index ["reset_password_token"], name: "index_supervising_organizations_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applicants", "staffs", column: "creator_id"
end
