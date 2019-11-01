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

ActiveRecord::Schema.define(version: 20190404211338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "antennas", force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_antennas_on_channel_id"
    t.index ["user_id"], name: "index_antennas_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_channels_on_name", unique: true
  end

  create_table "devices", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_devices_on_name", unique: true
  end

  create_table "own_boxes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "set_top_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["set_top_box_id"], name: "index_own_boxes_on_set_top_box_id"
    t.index ["user_id"], name: "index_own_boxes_on_user_id"
  end

  create_table "own_devices", force: :cascade do |t|
    t.integer "user_id"
    t.integer "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_own_devices_on_device_id"
    t.index ["user_id"], name: "index_own_devices_on_user_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name", null: false
    t.string "link"
    t.float "cost"
    t.boolean "DVR"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_packages_on_name", unique: true
  end

  create_table "perferences", force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.integer "rate", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_perferences_on_channel_id"
    t.index ["user_id"], name: "index_perferences_on_user_id"
  end

  create_table "provide_channels", force: :cascade do |t|
    t.integer "package_id"
    t.integer "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_provide_channels_on_channel_id"
    t.index ["package_id"], name: "index_provide_channels_on_package_id"
  end

  create_table "set_top_boxes", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_set_top_boxes_on_name", unique: true
  end

  create_table "support_boxes", force: :cascade do |t|
    t.integer "package_id"
    t.integer "set_top_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_support_boxes_on_package_id"
    t.index ["set_top_box_id"], name: "index_support_boxes_on_set_top_box_id"
  end

  create_table "support_devices", force: :cascade do |t|
    t.integer "package_id"
    t.integer "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_support_devices_on_device_id"
    t.index ["package_id"], name: "index_support_devices_on_package_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
