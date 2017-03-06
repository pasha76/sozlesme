class Agreement < ApplicationRecord
  has_many :user_agreementaccesses
  has_many :users, through: :user_agreementaccesses
  has_many :sections
  has_many :terms
  belongs_to :draftagreement
  belongs_to :demand
  belongs_to :user
  belongs_to :agreementtemplate
  has_many :notes
  attr_accessor :emails
  include Workflow
  workflow do
    state :new do
      event :submit_to_vendor, :transitions_to => :vendor_feedback
    end
    state :vendor_feedback do
      event :vendor_approve, :transitions_to => :vendor_approved
      event :vendor_draft, :transitions_to => :vendor_feedback
    end

    state :vendor_approved do
      event :company_approve, :transitions_to => :approved
      event :company_draft, :transitions_to => :vendor_feedback
    end

    state :approved
  end


end
