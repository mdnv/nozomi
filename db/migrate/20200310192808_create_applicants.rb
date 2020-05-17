class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants do |t|
      t.references :creator, index: true, foreign_key: {to_table: :staffs}

      t.string   :firstname
      t.string   :lastname
      t.string   :fullname
      t.string   :fullname_katakana
      t.string   :fullname_kanji
      t.string   :other_name

      t.integer  :gender, limit: 1, default: 0
      t.datetime :birthdate
      t.string   :birthplace
      t.string   :hometown

      t.string   :vietnam_phone_number
      t.string   :japan_phone_number
      t.string   :japan_address
      t.text     :personal_note

      ## Logical delete
      t.integer  :availability, limit: 1, default: 1
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
