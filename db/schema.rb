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

ActiveRecord::Schema[8.1].define(version: 2026_01_11_195606) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "jwt_denylists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "exp"
    t.string "jti"
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "plan"
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "billing_cycle", default: "monthly"
    t.datetime "created_at", null: false
    t.string "currency", default: "DKK"
    t.bigint "organization_id", null: false
    t.date "renewal_date"
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id", null: false
    t.index ["organization_id"], name: "index_subscriptions_on_organization_id"
    t.index ["vendor_id"], name: "index_subscriptions_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", null: false
    t.bigint "organization_id"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "logo_url"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "organizations"
  add_foreign_key "subscriptions", "vendors"
end
