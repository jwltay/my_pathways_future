# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_27_072857) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "career_programmes", force: :cascade do |t|
    t.bigint "career_id", null: false
    t.bigint "programme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id"], name: "index_career_programmes_on_career_id"
    t.index ["programme_id"], name: "index_career_programmes_on_programme_id"
  end

  create_table "career_soft_skills", force: :cascade do |t|
    t.bigint "career_id", null: false
    t.bigint "soft_skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id"], name: "index_career_soft_skills_on_career_id"
    t.index ["soft_skill_id"], name: "index_career_soft_skills_on_soft_skill_id"
  end

  create_table "careers", force: :cascade do |t|
    t.integer "average_salary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "summary", null: false
    t.text "responsibilities", null: false
    t.text "progression", null: false
    t.text "education", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "programme_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "header"
    t.string "highlight_hex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programme_id"], name: "index_events_on_programme_id"
  end

  create_table "pathways", force: :cascade do |t|
    t.boolean "primary", default: false, null: false
    t.bigint "user_id", null: false
    t.bigint "programme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stage"
    t.index ["programme_id"], name: "index_pathways_on_programme_id"
    t.index ["user_id"], name: "index_pathways_on_user_id"
  end

  create_table "programme_subjects", force: :cascade do |t|
    t.bigint "programme_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programme_id"], name: "index_programme_subjects_on_programme_id"
    t.index ["subject_id"], name: "index_programme_subjects_on_subject_id"
  end

  create_table "programmes", force: :cascade do |t|
    t.integer "tuition_fees"
    t.integer "duration"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "summary", null: false
    t.string "name", null: false
    t.string "university", null: false
    t.text "overview", null: false
  end

  create_table "soft_skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.boolean "completed"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_soft_skills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "soft_skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["soft_skill_id"], name: "index_user_soft_skills_on_soft_skill_id"
    t.index ["user_id"], name: "index_user_soft_skills_on_user_id"
  end

  create_table "user_subjects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_user_subjects_on_subject_id"
    t.index ["user_id"], name: "index_user_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "current_profession"
    t.string "occupation"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "career_programmes", "careers"
  add_foreign_key "career_programmes", "programmes"
  add_foreign_key "career_soft_skills", "careers"
  add_foreign_key "career_soft_skills", "soft_skills"
  add_foreign_key "events", "programmes"
  add_foreign_key "pathways", "programmes"
  add_foreign_key "pathways", "users"
  add_foreign_key "programme_subjects", "programmes"
  add_foreign_key "programme_subjects", "subjects"
  add_foreign_key "tasks", "users"
  add_foreign_key "user_soft_skills", "soft_skills"
  add_foreign_key "user_soft_skills", "users"
  add_foreign_key "user_subjects", "subjects"
  add_foreign_key "user_subjects", "users"
end
