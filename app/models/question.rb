class Question < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :demand
  has_many :comments
  acts_as_commentable

end
