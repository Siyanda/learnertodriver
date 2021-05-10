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

ActiveRecord::Schema.define(version: 2021_05_07_003607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "value", default: 1, null: false
    t.string "content", null: false
    t.string "information", null: false
    t.bigint "correct_id"
    t.index ["correct_id"], name: "index_answers_on_correct_id"
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "answer_id", null: false
    t.bigint "question_id", null: false
    t.index ["answer_id"], name: "index_choices_on_answer_id"
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "status", default: 0, null: false
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.decimal "score", default: "0.0", null: false
    t.string "comment", default: "", null: false
    t.string "form_snapshot", default: "", null: false
    t.integer "status", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.bigint "user_id"
    t.bigint "quiz_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_id"], name: "index_evaluations_on_quiz_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "layout"
    t.string "slug"
    t.integer "status", default: 0, null: false
    t.bigint "editor_id"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["editor_id"], name: "index_pages_on_editor_id"
    t.index ["parent_id"], name: "index_pages_on_parent_id"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "image_data"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "excerpt"
    t.string "slug"
    t.integer "status", default: 0, null: false
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "content", null: false
    t.integer "kind", default: 0, null: false
    t.string "information", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", null: false
    t.integer "kind", default: 0, null: false
    t.string "information", default: "blank", null: false
    t.integer "duration", default: 3600, null: false
    t.string "description", default: "blank", null: false
    t.string "slug"
    t.index ["slug"], name: "index_quizzes_on_slug", unique: true
  end

  create_table "reactions", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "content", default: "", null: false
    t.integer "value", default: 0, null: false
    t.integer "kind", default: 0, null: false
    t.bigint "answer_id", null: false
    t.bigint "question_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_reactions_on_answer_id"
    t.index ["question_id"], name: "index_reactions_on_question_id"
    t.index ["quiz_id"], name: "index_reactions_on_quiz_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_responses_on_answer_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "specifications", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_specifications_on_question_id"
    t.index ["quiz_id"], name: "index_specifications_on_quiz_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tagable_type", null: false
    t.bigint "tagable_id", null: false
    t.text "content"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tagable_type", "tagable_id"], name: "index_tags_on_tagable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username", null: false
    t.jsonb "links"
    t.text "bio"
    t.date "birthday"
    t.integer "role", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.boolean "admin", default: false, null: false
    t.string "slug"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "answers", "answers", column: "correct_id"
  add_foreign_key "choices", "answers"
  add_foreign_key "choices", "questions"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "evaluations", "quizzes"
  add_foreign_key "evaluations", "users"
  add_foreign_key "pages", "pages", column: "parent_id"
  add_foreign_key "pages", "users", column: "editor_id"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "reactions", "answers"
  add_foreign_key "reactions", "questions"
  add_foreign_key "reactions", "quizzes"
  add_foreign_key "responses", "answers"
  add_foreign_key "responses", "questions"
  add_foreign_key "specifications", "questions"
  add_foreign_key "specifications", "quizzes"
end
