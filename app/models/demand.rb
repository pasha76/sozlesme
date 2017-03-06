class Demand < ApplicationRecord
  include Workflow
  workflow do
    state :new do
      event :submit_for_legal, :transitions_to => :legal_review
    end
    state :legal_review do
      event :submit_for_agreement, :transitions_to => :legal_writing
      event :submit_for_application, :transitions_to => :question_n_answer
    end

    state :legal_writing do
      event :submit_for_feedback, :transitions_to => :getting_feedback
      event :reject, :transitions_to => :rejected
      event :rewrite, :transitions_to => :legal_writing
    end

    state :question_n_answer do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
      event :answer, :transitions_to => :question_n_answer
      event :rewrite, :transitions_to => :legal_writing
    end

    state :getting_feedback do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
      event :rewrite, :transitions_to => :legal_writing
      event :submit_for_feedback, :transitions_to => :getting_feedback
    end
    state :accepted do
      event :reject, :transitions_to => :rejected
      event :submit_for_feedback, :transitions_to => :getting_feedback
    end
    state :rejected
  end

  belongs_to :user
  has_many :user_demandaccesses
  has_many :users, through: :user_demandaccesses
  belongs_to :draftagreement, optional: true
  belongs_to :agreement, optional: true
  belongs_to :company, :foreign_key => :vendor_company_id, optional: true
  attr_accessor :emails, :datafile

end
