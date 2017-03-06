class Term < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :agreement
  has_many :notes
  acts_as_commentable
  include Workflow
  workflow do
    state :draft do
      event :set_draft, :transitions_to => :draft
      event :set_approved, :transitions_to => :approved
    end
    state :approved do
      event :set_draft, :transitions_to => :draft
    end

  end
end
