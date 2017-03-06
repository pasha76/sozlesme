class Draftterm < ApplicationRecord
  has_one :company
  has_one :user
  has_one :draftagreement
  acts_as_commentable
  enum status:[:open,:in_progres,:published]

end
