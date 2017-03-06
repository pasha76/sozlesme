class Termtemplate < ApplicationRecord
  enum status: [:yeni,:taslak,:kullanimda,:deaktif]
  has_one :user

end
