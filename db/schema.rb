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

ActiveRecord::Schema.define(version: 2019_06_12_092225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contractor_availabilities", force: :cascade do |t|
    t.date "date_available"
    t.bigint "job_id"
    t.bigint "contractor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_contractor_availabilities_on_contractor_id"
    t.index ["job_id"], name: "index_contractor_availabilities_on_job_id"
  end

  create_table "job_stages", force: :cascade do |t|
    t.bigint "job_id"
    t.integer "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "changed_at"
    t.index ["job_id"], name: "index_job_stages_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "property_id"
    t.string "category"
    t.text "description"
    t.bigint "contractor_id"
    t.integer "current_stage"
    t.date "date"
    t.integer "final_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice"
    t.boolean "resolved"
    t.integer "rating"
    t.index ["contractor_id"], name: "index_jobs_on_contractor_id"
    t.index ["property_id"], name: "index_jobs_on_property_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_messages_on_job_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "photo_videos", force: :cascade do |t|
    t.integer "stage"
    t.bigint "job_id"
    t.string "photo_video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_photo_videos_on_job_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "landlord_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["landlord_id"], name: "index_properties_on_landlord_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "contractor_id"
    t.bigint "job_id"
    t.integer "price"
    t.boolean "submitted"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quote"
    t.index ["contractor_id"], name: "index_quotes_on_contractor_id"
    t.index ["job_id"], name: "index_quotes_on_job_id"
  end

  create_table "tenancies", force: :cascade do |t|
    t.bigint "property_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "deposit"
    t.boolean "deposit_refunded"
    t.integer "rent_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_tenancies_on_property_id"
  end

  create_table "tenants_tenancies", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "tenancy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenancy_id"], name: "index_tenants_tenancies_on_tenancy_id"
    t.index ["tenant_id"], name: "index_tenants_tenancies_on_tenant_id"
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
    t.string "phone_number"
    t.string "user_type"
    t.string "contractor_type"
    t.string "avatar"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contractor_availabilities", "jobs"
  add_foreign_key "contractor_availabilities", "users", column: "contractor_id"
  add_foreign_key "job_stages", "jobs"
  add_foreign_key "jobs", "properties"
  add_foreign_key "jobs", "users", column: "contractor_id"
  add_foreign_key "messages", "jobs"
  add_foreign_key "messages", "users"
  add_foreign_key "photo_videos", "jobs"
  add_foreign_key "properties", "users", column: "landlord_id"
  add_foreign_key "quotes", "jobs"
  add_foreign_key "quotes", "users", column: "contractor_id"
  add_foreign_key "tenancies", "properties"
  add_foreign_key "tenants_tenancies", "tenancies"
  add_foreign_key "tenants_tenancies", "users", column: "tenant_id"
end
