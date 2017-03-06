class AddAgreementIdToTerms < ActiveRecord::Migration[5.0]
  def change
    add_reference :terms, :agreement, foreign_key: true
  end
end
