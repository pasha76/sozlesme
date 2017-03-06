class AddAgreementIdToSections < ActiveRecord::Migration[5.0]
  def change
    add_reference :sections, :agreement, foreign_key: true
  end
end
