class Sectiontemplate < ApplicationRecord
  enum status: [:yeni,:taslak,:kullanimda,:deaktif]
  has_one :user
  has_one :company

  def self.all_templates(company_id)
    return Sectiontemplate.where(["company_id=?",company_id])
  end

end
