class Draftsection < ApplicationRecord
  has_one :user
  has_one :draftagreement
  has_one :company
  has_many :draftterms
  enum status:[:open,:in_progres,:published]

end
