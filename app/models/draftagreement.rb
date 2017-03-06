class Draftagreement < ApplicationRecord
  include Workflow
  workflow do
    state :new do
      event :submit_for_legal, :transitions_to => :legal_writing
      event :create_copy, :transitions_to => :getting_feedback
    end
    state :legal_writing do
      event :submit_for_feedback, :transitions_to => :getting_feedback
    end
    state :getting_feedback do
      event :set_access_rights, :transitions_to => :setting_access
    end

    state :setting_access do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
      event :submit_for_feedback, :transitions_to => :getting_feedback
    end
    state :accepted do
    event :submit_for_feedback, :transitions_to => :getting_feedback
  end
    state :rejected
  end


  validates :name, presence: true
  enum status:[:open,:in_progress,:published,:approved_by_user]
  attr_accessor :purchaser_company,:vendor_company
  has_many :draftsections
  has_many :draftterms
  has_one :agreementtemplate
  has_one :demand
  has_one :user


  def agreement_type
    return Agreementtemplate.find(self.agreementtemplate_id).name
  end
end
