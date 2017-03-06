class Draftnote < ApplicationRecord
  belongs_to :draftagreement
  belongs_to :user
  def as_json(options = { })
    h = super(options)
    h[:creator]   = self.user.name
    h
  end

end
