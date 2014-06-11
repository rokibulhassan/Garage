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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140428164828) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "base_unit_systems", :force => true do |t|
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "use_production_codes", :default => false, :null => false
    t.boolean  "open_to_fixes",        :default => false, :null => false
    t.integer  "upvotes_count",        :default => 0
    t.integer  "downvotes_count",      :default => 0
    t.boolean  "pending",              :default => false, :null => false
    t.boolean  "rejected",             :default => false, :null => false
    t.string   "vehicle_types"
  end

  add_index "brands", ["name"], :name => "index_brands_on_name", :unique => true

  create_table "change_set_properties", :force => true do |t|
    t.integer  "change_set_id",          :null => false
    t.integer  "property_definition_id", :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "value"
  end

  create_table "change_sets", :force => true do |t|
    t.string   "name",                          :null => false
    t.integer  "vehicle_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "default",    :default => false
  end

  create_table "collages", :force => true do |t|
    t.integer  "gallery_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "active_layout"
    t.integer  "position"
    t.integer  "profile_id"
    t.string   "type"
    t.integer  "vehicle_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "picture_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comparison_table_vehicles", :force => true do |t|
    t.integer  "comparison_table_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "comparison_table_vehicles", ["comparison_table_id"], :name => "index_comparison_table_vehicles_on_comparison_table_id"
  add_index "comparison_table_vehicles", ["vehicle_id"], :name => "index_comparison_table_vehicles_on_vehicle_id"

  create_table "comparison_tables", :force => true do |t|
    t.string   "label"
    t.integer  "user_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.text     "selected_change_set_ids", :default => ""
    t.integer  "save_id"
  end

  add_index "comparison_tables", ["user_id"], :name => "index_comparison_tables_on_user_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "corrections", :force => true do |t|
    t.integer  "version_property_id"
    t.integer  "corrector_id"
    t.string   "value"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "cutouts", :force => true do |t|
    t.integer  "collage_id"
    t.integer  "row"
    t.integer  "col"
    t.string   "image"
    t.text     "crop"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "picture_id"
    t.string   "layout"
    t.integer  "image_revision",   :default => 1
    t.string   "youtube_video_id"
    t.integer  "youtube_start_at"
    t.boolean  "youtube_hd"
  end

  create_table "favorites", :force => true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.string   "label"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "page_url"
  end

  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "field_definitions", :force => true do |t|
    t.string   "name"
    t.string   "label_fr"
    t.string   "label_en"
    t.string   "type"
    t.integer  "fieldset_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "unit_id"
    t.text     "values"
    t.string   "values_type"
    t.string   "scoped_by"
    t.integer  "unit_type_id"
    t.string   "keyword"
    t.integer  "priority"
  end

  add_index "field_definitions", ["fieldset_id"], :name => "index_vehicle_template_field_definitions_on_fieldset_id"
  add_index "field_definitions", ["unit_id"], :name => "index_vehicle_template_field_definitions_on_unit_id"
  add_index "field_definitions", ["unit_type_id"], :name => "index_field_definitions_on_unit_type_id"

  create_table "fieldsets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "label_en"
    t.string   "label_fr"
    t.integer  "priority",   :default => 0
  end

  create_table "fixes", :force => true do |t|
    t.string   "fixable_type"
    t.integer  "fixable_id"
    t.string   "attribute_name"
    t.string   "value"
    t.integer  "upvotes_count",   :default => 0
    t.integer  "downvotes_count", :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "locale"
    t.boolean  "pending",         :default => true,  :null => false
    t.boolean  "rejected",        :default => false, :null => false
    t.datetime "validated_at"
  end

  create_table "followings", :force => true do |t|
    t.string   "thing_type"
    t.integer  "thing_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "followings", ["thing_type", "thing_id"], :name => "index_followings_on_thing_type_and_thing_id"
  add_index "followings", ["user_id", "thing_type", "thing_id"], :name => "index_followings_on_user_id_thing_type_and_thing_id", :unique => true
  add_index "followings", ["user_id"], :name => "index_followings_on_user_id"

  create_table "galleries", :force => true do |t|
    t.string   "title"
    t.integer  "cover_picture_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "token"
    t.boolean  "finished",         :default => false,    :null => false
    t.integer  "vehicle_id"
    t.string   "layout",           :default => "grid"
    t.string   "privacy",          :default => "public"
    t.integer  "position"
    t.integer  "user_id"
  end

  add_index "galleries", ["cover_picture_id"], :name => "index_galleries_on_cover_picture_id"

  create_table "generations", :force => true do |t|
    t.integer  "started_at"
    t.integer  "finished_at"
    t.integer  "version_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "number"
  end

  create_table "global_select_options", :force => true do |t|
    t.string   "vehicle_type"
    t.string   "name"
    t.text     "options"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "model_select_options", :force => true do |t|
    t.integer  "model_id"
    t.string   "name"
    t.text     "options"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "vehicle_type"
    t.boolean  "pending",         :default => true,  :null => false
    t.boolean  "rejected",        :default => false, :null => false
    t.integer  "upvotes_count",   :default => 0,     :null => false
    t.integer  "downvotes_count", :default => 0,     :null => false
  end

  add_index "models", ["brand_id"], :name => "index_models_on_brand_id"

  create_table "modification_change_sets", :force => true do |t|
    t.integer "modification_id", :null => false
    t.integer "change_set_id",   :null => false
  end

  add_index "modification_change_sets", ["modification_id", "change_set_id"], :name => "by_modification_and_change_set", :unique => true

  create_table "modification_properties", :force => true do |t|
    t.integer  "property_definition_id"
    t.integer  "modification_id"
    t.string   "value",                  :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "modification_properties", ["modification_id", "property_definition_id"], :name => "by_modification_and_property_definition", :unique => true

  create_table "modifications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "vehicle_id"
  end

  add_index "modifications", ["vehicle_id"], :name => "index_modifications_on_vehicle_id"

  create_table "news_feeds", :force => true do |t|
    t.integer  "listener_id",                     :null => false
    t.integer  "initiator_id",                    :null => false
    t.string   "event_type",                      :null => false
    t.integer  "target_id",                       :null => false
    t.string   "target_type",                     :null => false
    t.text     "extras"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "child_ids"
    t.string   "wait_on_type"
    t.integer  "wait_on_id"
    t.boolean  "hidden",       :default => false
  end

  add_index "news_feeds", ["target_id", "target_type"], :name => "index_news_feeds_on_target_id_and_target_type"

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "ownerships", :force => true do |t|
    t.integer  "vehicle_id"
    t.string   "status"
    t.string   "owner_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
  end

  create_table "part_purchases", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "vendor_id"
    t.integer  "part_id"
    t.boolean  "special",         :default => false, :null => false
    t.float    "price"
    t.integer  "quantity"
    t.date     "bought_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "modification_id"
    t.boolean  "main",            :default => false
  end

  add_index "part_purchases", ["modification_id"], :name => "index_part_purchases_on_modification_id"
  add_index "part_purchases", ["part_id"], :name => "index_part_purchases_on_part_id"
  add_index "part_purchases", ["vendor_id"], :name => "index_part_purchases_on_vendor_id"

  create_table "parts", :force => true do |t|
    t.string   "label_fr"
    t.string   "label_en"
    t.string   "manufacturer_reference"
    t.boolean  "special",                :default => false, :null => false
    t.integer  "category_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "brand_id"
  end

  add_index "parts", ["brand_id"], :name => "index_parts_on_brand_id"
  add_index "parts", ["category_id"], :name => "index_parts_on_category_id"

  create_table "pictures", :force => true do |t|
    t.text     "title"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "gallery_id"
    t.text     "image_meta"
    t.string   "image"
    t.integer  "image_big_width"
    t.integer  "image_big_height"
    t.integer  "image_rotation",   :default => 0
    t.integer  "image_revision",   :default => 1
    t.text     "image_blur_areas"
    t.integer  "position"
    t.string   "type"
    t.integer  "profile_id"
    t.string   "media_type",       :default => "picture"
    t.string   "video_id"
    t.integer  "vehicle_id"
  end

  add_index "pictures", ["gallery_id"], :name => "index_pictures_on_gallery_id"

  create_table "prewritten_comments", :force => true do |t|
    t.string   "body_en"
    t.string   "body_fr"
    t.string   "type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "vehicle_type"
    t.string   "body_ar"
    t.string   "body_bg"
    t.string   "body_cs"
    t.string   "body_da"
    t.string   "body_de"
    t.string   "body_es"
    t.string   "body_fa"
    t.string   "body_fi"
    t.string   "body_grc"
    t.string   "body_hu"
    t.string   "body_id"
    t.string   "body_it"
    t.string   "body_ja"
    t.string   "body_ko"
    t.string   "body_nl"
    t.string   "body_no"
    t.string   "body_pl"
    t.string   "body_pt"
    t.string   "body_ro"
    t.string   "body_ru"
    t.string   "body_sk"
    t.string   "body_sv"
    t.string   "body_tr"
    t.string   "body_vi"
    t.string   "body_zh"
  end

  create_table "prewritten_comments_version_user", :force => true do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.integer  "prewritten_comment_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "properties_group_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "format_string"
    t.boolean  "least_is_best",       :default => false, :null => false
  end

  add_index "properties", ["properties_group_id"], :name => "index_properties_on_properties_group_id"

  create_table "properties_groups", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "vehicle_type"
  end

  create_table "property_attribute_values", :force => true do |t|
    t.string   "value"
    t.integer  "property_attribute_id"
    t.integer  "property_instance_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "property_attribute_values", ["property_attribute_id"], :name => "index_property_attribute_values_on_property_attribute_id"
  add_index "property_attribute_values", ["property_instance_id"], :name => "index_property_attribute_values_on_property_instance_id"

  create_table "property_attributes", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
    t.text     "values"
  end

  add_index "property_attributes", ["property_id"], :name => "index_property_attributes_on_property_id"

  create_table "property_definitions", :force => true do |t|
    t.string   "name"
    t.string   "comparator", :default => "Comparator::Base"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "unit_type"
  end

  create_table "property_instances", :force => true do |t|
    t.integer  "property_id"
    t.integer  "resource_with_property_id"
    t.string   "resource_with_property_type"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "property_instances", ["resource_with_property_id", "resource_with_property_type"], :name => "index_property_instances_on_resource_with_property"

  create_table "property_suggestions", :force => true do |t|
    t.integer  "version_id"
    t.integer  "property_instance_id"
    t.integer  "upvotes_count"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "property_id"
  end

  add_index "property_suggestions", ["property_id"], :name => "index_property_suggestions_on_property_id"
  add_index "property_suggestions", ["property_instance_id"], :name => "index_property_suggestions_on_property_instance_id"
  add_index "property_suggestions", ["version_id"], :name => "index_property_suggestions_on_version_id"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "services", :force => true do |t|
    t.string   "label"
    t.integer  "vendor_id"
    t.string   "service_type"
    t.float    "price"
    t.date     "done_at"
    t.string   "duration_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "modification_id"
  end

  add_index "services", ["vendor_id"], :name => "index_services_on_vendor_id"

  create_table "side_views", :force => true do |t|
    t.string   "image",            :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "version_id"
    t.text     "image_dimensions"
  end

  create_table "supplier_references", :force => true do |t|
    t.string   "name"
    t.string   "reference"
    t.boolean  "obsolete"
    t.integer  "part_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "supplier_references", ["part_id"], :name => "index_supplier_references_on_part_id"

  create_table "translation_keys", :force => true do |t|
    t.string   "key",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "translation_keys", ["key"], :name => "index_translation_keys_on_key"

  create_table "translation_texts", :force => true do |t|
    t.text     "text"
    t.string   "locale"
    t.integer  "translation_key_id", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "translation_texts", ["translation_key_id"], :name => "index_translation_texts_on_translation_key_id"

  create_table "user_oppositions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "opposer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_oppositions", ["user_id", "opposer_id"], :name => "by_user_and_opposer", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "persistence_token"
    t.string   "country_code"
    t.string   "city"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "facebook_access_token"
    t.string   "locale"
    t.string   "language_code"
    t.boolean  "confirmed",                :default => false, :null => false
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_received_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "facebook_id"
    t.string   "password_recovery_token"
    t.boolean  "newbie",                   :default => true,  :null => false
    t.boolean  "first_name_public",        :default => false, :null => false
    t.boolean  "last_name_public",         :default => false, :null => false
    t.boolean  "emailing_allowed",         :default => false, :null => false
    t.string   "currency"
    t.boolean  "city_public",              :default => false, :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar"
    t.integer  "unit_system_id"
  end

  create_table "vehicle_bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "vehicle_bookmarks", ["user_id", "vehicle_id"], :name => "by_user_and_vehicle", :unique => true

  create_table "vehicle_templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "vehicles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "vehicle_type"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "brand_id"
    t.integer  "model_id"
    t.string   "avatar"
    t.integer  "version_id"
    t.integer  "year"
    t.integer  "engine_id"
    t.integer  "side_view_id"
    t.integer  "current_change_set_id"
  end

  add_index "vehicles", ["brand_id"], :name => "index_vehicles_on_brand_id"
  add_index "vehicles", ["engine_id"], :name => "index_vehicles_on_engine_id"
  add_index "vehicles", ["model_id"], :name => "index_vehicles_on_model_id"
  add_index "vehicles", ["user_id"], :name => "index_vehicles_on_user_id"
  add_index "vehicles", ["version_id"], :name => "index_vehicles_on_version_id"

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "street"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "version_properties", :force => true do |t|
    t.integer  "version_id"
    t.integer  "property_definition_id"
    t.string   "value"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "user_id"
    t.boolean  "accepted"
  end

  add_index "version_properties", ["version_id", "property_definition_id"], :name => "by_version_and_property_definition", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "name"
    t.string   "label_fr"
    t.string   "label_en"
    t.integer  "model_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "vehicle_figure_id"
    t.boolean  "pending",              :default => true,  :null => false
    t.boolean  "rejected",             :default => false, :null => false
    t.integer  "upvotes_count",        :default => 0,     :null => false
    t.integer  "downvotes_count",      :default => 0,     :null => false
    t.integer  "production_year"
    t.string   "production_code"
    t.string   "body"
    t.string   "market_version_name"
    t.string   "status"
    t.string   "transmission_numbers"
    t.string   "transmission_type"
    t.integer  "door_count"
    t.integer  "doors"
    t.string   "energy"
    t.string   "transmission_details"
    t.boolean  "show_model_name"
    t.string   "second_name"
  end

  add_index "versions", ["model_id"], :name => "index_versions_on_model_id"
  add_index "versions", ["vehicle_figure_id"], :name => "index_versions_on_vehicle_figure_id"

  create_table "votes", :force => true do |t|
    t.integer  "fixable_id"
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "fixable_type"
  end

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
