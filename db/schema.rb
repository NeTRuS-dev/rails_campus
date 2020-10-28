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

ActiveRecord::Schema.define(version: 2020_10_26_133518) do

  create_table "employer_infos", force: :cascade do |t|
    t.string "organization_name"
    t.text "organization_description"
    t.string "contact_phone"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_employer_infos_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
  end

  create_table "groups_subjects", id: false, force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "group_id", null: false
  end

  create_table "marks", force: :cascade do |t|
    t.integer "value"
    t.integer "subject_id", null: false
    t.integer "student_info_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_info_id"], name: "index_marks_on_student_info_id"
    t.index ["subject_id"], name: "index_marks_on_subject_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "skills_users", id: false, force: :cascade do |t|
    t.integer "skill_id", null: false
    t.integer "user_id", null: false
  end

  create_table "skills_vacancies", id: false, force: :cascade do |t|
    t.integer "skill_id", null: false
    t.integer "vacancy_id", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "education_type"
    t.integer "max_courses", default: 4
  end

  create_table "student_infos", force: :cascade do |t|
    t.text "about_me"
    t.text "full_about_me"
    t.bigint "desired_wage"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contact_phone"
    t.index ["user_id"], name: "index_student_infos_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "specialty_id"
    t.index ["specialty_id"], name: "index_subjects_on_specialty_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.date "birth_date"
    t.integer "group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "wage"
    t.string "position"
    t.integer "employer_info_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_info_id"], name: "index_vacancies_on_employer_info_id"
  end

  add_foreign_key "marks", "student_infos"
  add_foreign_key "marks", "subjects"
end
