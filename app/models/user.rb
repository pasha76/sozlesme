class User < ApplicationRecord
  belongs_to :company, optional:true
  has_many :user_demandaccesses
  has_many :demands,through: :user_demandaccesses

  has_many :user_agreementaccesses
  has_many :agreements,through: :user_agreementaccesses

  has_many :notices

  enum role: [:user,:purchaser, :vendor,:vendor_legal,:legal, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end


  def legal_company
    Company.find(self.legal_company_id) unless self.legal_company_id.nil?
  end

  def lawyers
    self.legal_company.users.where(role:User.roles[:legal]) unless self.legal_company_id.nil?
  end


  def my_demands
    self.demands.with_legal_review_state
  end

  def is_vendor?

  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
