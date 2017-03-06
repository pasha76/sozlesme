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

ActiveRecord::Schema.define(version: 20170304171512) do

  create_table "agreements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "draftagreement_id"
    t.integer  "agreementtemplate_id"
    t.integer  "demand_id"
    t.string   "name"
    t.string   "workflow_state"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "company_id"
    t.index ["agreementtemplate_id"], name: "index_agreements_on_agreementtemplate_id"
    t.index ["demand_id"], name: "index_agreements_on_demand_id"
    t.index ["draftagreement_id"], name: "index_agreements_on_draftagreement_id"
    t.index ["user_id"], name: "index_agreements_on_user_id"
  end

  create_table "agreementtemplates", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.index ["user_id"], name: "index_agreementtemplates_on_user_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "tax_no"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "demands", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "content"
    t.integer  "to_role"
    t.integer  "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "workflow_state"
    t.integer  "vendor_company_id"
    t.index ["company_id"], name: "index_demands_on_company_id"
    t.index ["user_id"], name: "index_demands_on_user_id"
  end

  create_table "draftagreements", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "purchaser_company_id"
    t.integer  "vendor_company_id"
    t.integer  "status"
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "demand_id"
    t.integer  "agreementtemplate_id"
    t.string   "workflow_state"
    t.integer  "order_no"
    t.index ["company_id"], name: "index_draftagreements_on_company_id"
    t.index ["user_id"], name: "index_draftagreements_on_user_id"
  end

  create_table "draftnotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "draftagreement_id"
    t.string   "content"
    t.string   "workflow_state"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["draftagreement_id"], name: "index_draftnotes_on_draftagreement_id"
    t.index ["user_id"], name: "index_draftnotes_on_user_id"
  end

  create_table "draftsections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "draftagreement_id"
    t.integer  "draft_id"
    t.string   "name"
    t.integer  "status"
    t.decimal  "order",             precision: 2, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "order_no"
    t.index ["company_id"], name: "index_draftsections_on_company_id"
    t.index ["draft_id"], name: "index_draftsections_on_draft_id"
    t.index ["draftagreement_id"], name: "index_draftsections_on_draftagreement_id"
    t.index ["user_id"], name: "index_draftsections_on_user_id"
  end

  create_table "draftterms", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "draftsection_id"
    t.integer  "draft_id"
    t.integer  "draftagreement_id"
    t.string   "content"
    t.integer  "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "section_order_no"
    t.integer  "order_no"
    t.index ["company_id"], name: "index_draftterms_on_company_id"
    t.index ["draft_id"], name: "index_draftterms_on_draft_id"
    t.index ["draftagreement_id"], name: "index_draftterms_on_draftagreement_id"
    t.index ["draftsection_id"], name: "index_draftterms_on_draftsection_id"
    t.index ["user_id"], name: "index_draftterms_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.integer  "term_id"
    t.string   "content"
    t.string   "workflow_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["agreement_id"], name: "index_notes_on_agreement_id"
    t.index ["term_id"], name: "index_notes_on_term_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.string   "content"
    t.integer  "notice_type"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "demand_id"
    t.index ["company_id"], name: "index_questions_on_company_id"
    t.index ["demand_id"], name: "index_questions_on_demand_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "draftagreement_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "agreement_id"
    t.index ["agreement_id"], name: "index_sections_on_agreement_id"
    t.index ["draftagreement_id"], name: "index_sections_on_draftagreement_id"
    t.index ["user_id"], name: "index_sections_on_user_id"
  end

  create_table "sectiontemplates", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.integer  "user_id"
    t.integer  "agreementtemplate_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "company_id"
    t.integer  "status"
    t.index ["agreementtemplate_id"], name: "index_sectiontemplates_on_agreementtemplate_id"
    t.index ["user_id"], name: "index_sectiontemplates_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.integer  "draftagreement_id"
    t.integer  "user_id"
    t.integer  "section_id"
    t.integer  "company_id"
    t.string   "content"
    t.string   "workflow_state"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "agreement_id"
    t.index ["agreement_id"], name: "index_terms_on_agreement_id"
    t.index ["company_id"], name: "index_terms_on_company_id"
    t.index ["draftagreement_id"], name: "index_terms_on_draftagreement_id"
    t.index ["section_id"], name: "index_terms_on_section_id"
    t.index ["user_id"], name: "index_terms_on_user_id"
  end

  create_table "termtemplates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "content"
    t.string   "subject"
    t.string   "keywords"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_termtemplates_on_company_id"
    t.index ["user_id"], name: "index_termtemplates_on_user_id"
  end

  create_table "user_agreementaccesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "draftagreement_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "user_type"
    t.integer  "agreement_id"
    t.index ["agreement_id"], name: "index_user_agreementaccesses_on_agreement_id"
    t.index ["draftagreement_id"], name: "index_user_agreementaccesses_on_draftagreement_id"
    t.index ["user_id"], name: "index_user_agreementaccesses_on_user_id"
  end

  create_table "user_demandaccesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "demand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demand_id"], name: "index_user_demandaccesses_on_demand_id"
    t.index ["user_id"], name: "index_user_demandaccesses_on_user_id"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
    t.integer  "company_id"
    t.integer  "legal_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
