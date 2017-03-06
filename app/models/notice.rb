class Notice < ApplicationRecord
  belongs_to :user

  def self.inform(user_id,content,type,url)
    Notice.create(user_id:user_id,content:content,notice_type:type,url:url)
  end
end
