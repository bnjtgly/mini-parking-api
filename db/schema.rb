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

ActiveRecord::Schema[7.0].define(version: 2022_03_13_230719) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "api_clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "api_key", limit: 36, null: false
    t.string "secret_key"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "customer_parkings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "customer_id", null: false
    t.uuid "parking_slot_id", null: false
    t.uuid "parking_status_id"
    t.boolean "is_returnee", default: false, null: false
    t.integer "current_flat_rate", default: 3, null: false
    t.integer "accumulated_hours", default: 0, null: false
    t.datetime "valid_from", default: -> { "now()" }, null: false
    t.datetime "valid_thru"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_parkings_on_customer_id"
    t.index ["parking_slot_id"], name: "index_customer_parkings_on_parking_slot_id"
    t.index ["parking_status_id"], name: "index_customer_parkings_on_parking_status_id"
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "vehicle_type_id"
    t.string "complete_name"
    t.string "plate_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_type_id"], name: "index_customers_on_vehicle_type_id"
  end

  create_table "entities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "entity_number"
    t.string "entity_name"
    t.string "entity_def"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_number"], name: "index_entities_on_entity_number", unique: true
  end

  create_table "entry_points", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parking_complex_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_complex_id"], name: "index_entry_points_on_parking_complex_id"
  end

  create_table "invoices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "customer_parking_id", null: false
    t.uuid "customer_id", null: false
    t.uuid "transaction_status_id"
    t.boolean "is_flatrate_settled", default: false, null: false
    t.integer "parked_hours", default: 0, null: false
    t.float "parking_fee", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["customer_parking_id"], name: "index_invoices_on_customer_parking_id"
    t.index ["transaction_status_id"], name: "index_invoices_on_transaction_status_id"
  end

  create_table "jwt_denylists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "parking_complexes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_parking_complexes_on_name", unique: true
  end

  create_table "parking_slots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parking_complex_id", null: false
    t.uuid "parking_slot_type_id"
    t.uuid "parking_slot_status_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_complex_id"], name: "index_parking_slots_on_parking_complex_id"
    t.index ["parking_slot_status_id"], name: "index_parking_slots_on_parking_slot_status_id"
    t.index ["parking_slot_type_id"], name: "index_parking_slots_on_parking_slot_type_id"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "role_name"
    t.string "role_def"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_name"], name: "index_roles_on_role_name", unique: true
  end

  create_table "slot_entrypoints", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parking_slot_id", null: false
    t.uuid "entry_point_id", null: false
    t.float "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_point_id"], name: "index_slot_entrypoints_on_entry_point_id"
    t.index ["parking_slot_id"], name: "index_slot_entrypoints_on_parking_slot_id"
  end

  create_table "sub_entities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "entity_id", null: false
    t.string "sort_order"
    t.string "display"
    t.string "value_str"
    t.jsonb "metadata", default: "{}", null: false
    t.string "status", default: "Active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id", "display", "value_str"], name: "index_sub_entities_on_entity_id_and_display_and_value_str", unique: true
    t.index ["entity_id"], name: "index_sub_entities_on_entity_id"
  end

  create_table "user_roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.uuid "api_client_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_client_id"], name: "index_users_on_api_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "customer_parkings", "customers"
  add_foreign_key "customer_parkings", "parking_slots"
  add_foreign_key "customer_parkings", "sub_entities", column: "parking_status_id"
  add_foreign_key "customers", "sub_entities", column: "vehicle_type_id"
  add_foreign_key "entry_points", "parking_complexes"
  add_foreign_key "invoices", "customer_parkings"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "sub_entities", column: "transaction_status_id"
  add_foreign_key "parking_slots", "parking_complexes"
  add_foreign_key "parking_slots", "sub_entities", column: "parking_slot_status_id"
  add_foreign_key "parking_slots", "sub_entities", column: "parking_slot_type_id"
  add_foreign_key "slot_entrypoints", "entry_points"
  add_foreign_key "slot_entrypoints", "parking_slots"
  add_foreign_key "sub_entities", "entities"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "api_clients"
end
