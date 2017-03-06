class Section < ApplicationRecord
  belongs_to :agreement
  belongs_to :user
  has_many :terms

end
