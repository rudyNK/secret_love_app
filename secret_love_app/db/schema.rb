ActiveRecord::Schema.define(version: 20180412143646) do

    create_table "todos", force: :cascade do |t|
      t.string   "chores"
      t.integer  "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "users", force: :cascade do |t|
      t.string   "name"
      t.string   "email"
      t.string   "password_digest"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end
  
  end
  