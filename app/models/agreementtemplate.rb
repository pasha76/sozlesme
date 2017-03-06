class Agreementtemplate < ApplicationRecord
  enum status: [:draft,:in_use,:deaktif]
  has_one :user
  has_many :sectiontemplates
  has_one :company
  belongs_to :draftagreement, optional:true

  def self.all_in_use(company_id)
    return Agreementtemplate.where(["company_id=? and status=1",company_id])
  end

  def self.all_templates(company_id)
    return Agreementtemplate.where(["company_id=?",company_id])
  end
end
