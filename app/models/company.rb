class Company < ApplicationRecord
  has_many :users

  def demands(state)
      Demand.where(user_id:customers.ids,workflow_state: state)
  end

  def lawyers
    self.users.where(role:User.roles[:legal])
  end

  def customers
    User.where(legal_company_id:self.id,role:User.roles[:user])
  end

end
