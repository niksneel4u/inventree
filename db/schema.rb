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

ActiveRecord::Schema.define(version: 2019_04_11_093212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
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

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "contact_person_name"
    t.string "contact_person_number", default: "", null: false
    t.string "email"
    t.boolean "terms_and_conditions"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_person_number"], name: "index_companies_on_contact_person_number", unique: true
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((name)::text)", name: "index_entities_on_lower_name", unique: true
  end

  create_table "marketplace_mappings", force: :cascade do |t|
    t.bigint "marketplace_id"
    t.bigint "entity_id"
    t.string "entity_identifier"
    t.string "entity_identifier_value"
    t.boolean "block_present", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_marketplace_mappings_on_entity_id"
    t.index ["marketplace_id", "entity_id"], name: "index_marketplace_mappings_on_marketplace_id_and_entity_id", unique: true
    t.index ["marketplace_id"], name: "index_marketplace_mappings_on_marketplace_id"
  end

  create_table "marketplaces", force: :cascade do |t|
    t.string "name"
    t.string "website_url"
    t.string "image_xpath"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["website_url"], name: "index_marketplaces_on_website_url", unique: true
  end

  create_table "product_entities", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "entity_id"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_id"], name: "index_product_entities_on_entity_id"
    t.index ["product_id"], name: "index_product_entities_on_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "url"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_url"
    t.string "name"
    t.string "image"
    t.bigint "price"
    t.integer "status", default: 0
    t.bigint "marketplace_id"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["marketplace_id"], name: "index_products_on_marketplace_id"
  end

  create_table "receiver_emails", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_receiver_emails_on_company_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "marketplace_mappings", "entities"
  add_foreign_key "marketplace_mappings", "marketplaces"
  add_foreign_key "product_entities", "entities"
  add_foreign_key "product_entities", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "marketplaces"
  add_foreign_key "receiver_emails", "companies"
end
