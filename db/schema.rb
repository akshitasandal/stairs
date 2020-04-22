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

ActiveRecord::Schema.define(version: 20180216103920) do

  create_table "albums", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "company_id",  limit: 4
    t.boolean  "deleted"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "blog_post_images", force: :cascade do |t|
    t.string   "blog_post_image_file_name",    limit: 255
    t.string   "blog_post_image_content_type", limit: 255
    t.integer  "blog_post_image_file_size",    limit: 4
    t.datetime "blog_post_image_updated_at"
    t.integer  "blog_post_id",                 limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",                       limit: 255
    t.text     "description",                 limit: 65535
    t.text     "body",                        limit: 65535
    t.string   "keywords",                    limit: 255
    t.string   "featured_image_file_name",    limit: 255
    t.string   "featured_image_content_type", limit: 255
    t.integer  "featured_image_file_size",    limit: 4
    t.datetime "featured_image_updated_at"
    t.integer  "company_id",                  limit: 4
    t.integer  "post_category_id",            limit: 4
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.boolean  "deleted",                                   default: false
    t.string   "tags",                        limit: 255
    t.string   "slug",                        limit: 255
    t.integer  "blog_id",                     limit: 4
    t.boolean  "publish",                                   default: false
    t.integer  "user_id",                     limit: 4
  end

  create_table "blog_posts_post_categories", force: :cascade do |t|
    t.integer  "blog_post_id",     limit: 4
    t.integer  "post_category_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "blog_post_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                     limit: 255,   null: false
    t.integer  "functional_area_id",       limit: 4,     null: false
    t.string   "owner_name",               limit: 255,   null: false
    t.integer  "user_id",                  limit: 4
    t.string   "website",                  limit: 255
    t.string   "slug",                     limit: 255
    t.string   "primary_email",            limit: 255
    t.string   "secondary_email",          limit: 255
    t.string   "primary_contact_number",   limit: 255
    t.string   "secondary_contact_number", limit: 255
    t.string   "contact_person",           limit: 255
    t.integer  "state_id",                 limit: 4
    t.string   "city_id",                  limit: 255
    t.text     "address",                  limit: 65535
    t.boolean  "verified"
    t.boolean  "status"
    t.text     "overview",                 limit: 65535
    t.integer  "company_size_group_id",    limit: 4
    t.integer  "founded",                  limit: 4
    t.text     "latitude",                 limit: 65535
    t.text     "longitude",                limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "logo_file_name",           limit: 255
    t.string   "logo_content_type",        limit: 255
    t.integer  "logo_file_size",           limit: 4
    t.datetime "logo_updated_at"
    t.string   "cover_photo_file_name",    limit: 255
    t.string   "cover_photo_content_type", limit: 255
    t.integer  "cover_photo_file_size",    limit: 4
    t.datetime "cover_photo_updated_at"
  end

  create_table "company_followers", force: :cascade do |t|
    t.integer  "company_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "followed",             default: false
    t.boolean  "bookmarked",           default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "company_size_groups", force: :cascade do |t|
    t.string   "size_group", limit: 255
    t.boolean  "deleted"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "feed_details", force: :cascade do |t|
    t.integer  "feed_id",            limit: 4
    t.string   "video_type",         limit: 255
    t.string   "video_embed_url",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "feed_likes", force: :cascade do |t|
    t.integer  "feed_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.text     "content",    limit: 65535
    t.integer  "company_id", limit: 4,     null: false
    t.integer  "user_id",    limit: 4,     null: false
    t.integer  "feed_type",  limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "functional_areas", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "image_likes", force: :cascade do |t|
    t.integer  "image_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "album_id",           limit: 4
    t.integer  "user_id",            limit: 4
    t.boolean  "deleted"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "page_managers", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "company_id", limit: 4
    t.boolean  "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "role_id",     limit: 4
    t.integer  "resource_id", limit: 4
  end

  create_table "post_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "status",                 default: false
    t.boolean  "deleted",                default: false
    t.integer  "user_id",    limit: 4
  end

  create_table "resources", force: :cascade do |t|
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "deleted",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "testimonials", force: :cascade do |t|
    t.integer  "company_id", limit: 4
    t.text     "title",      limit: 65535
    t.text     "content",    limit: 65535,                 null: false
    t.boolean  "deleted",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "user_companies", force: :cascade do |t|
    t.integer "user_id",          limit: 4
    t.integer "company_id",       limit: 4
    t.string  "period",           limit: 255
    t.string  "designation",      limit: 255
    t.string  "responsibilities", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.text     "username",               limit: 65535
    t.text     "bio",                    limit: 65535
    t.text     "skills",                 limit: 65535
    t.string   "role_id",                limit: 255
    t.boolean  "verified",                             default: false
    t.boolean  "status",                               default: false
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.integer  "company_id",             limit: 4
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "view_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "deleted"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "views", force: :cascade do |t|
    t.string   "ip_address",   limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "view_type_id", limit: 4
    t.integer  "object_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
