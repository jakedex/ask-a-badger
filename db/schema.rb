# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160306023832) do

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.string   "body_plain"
    t.boolean  "as_text"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["title"], name: "index_courses_on_title", unique: true

  create_table "preusers", force: :cascade do |t|
    t.string   "phone"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.integer  "attempts",   default: 0
  end

  add_index "preusers", ["phone"], name: "index_preusers_on_phone", unique: true

  create_table "questions", force: :cascade do |t|
    t.integer  "preuser_id"
    t.integer  "user_id"
    t.text     "body"
    t.string   "title"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
    t.integer  "request_id"
  end

  add_index "questions", ["answer_id"], name: "index_questions_on_answer_id"
  add_index "questions", ["course_id"], name: "index_questions_on_course_id"
  add_index "questions", ["preuser_id"], name: "index_questions_on_preuser_id"
  add_index "questions", ["request_id"], name: "index_questions_on_request_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "requests", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.string   "body_plain"
    t.string   "response"
  end

  add_index "requests", ["question_id"], name: "index_requests_on_question_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
