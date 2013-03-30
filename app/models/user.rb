class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email

  has_many :kudos_send, class_name: "Kudo", foreign_key: :giver_id
  has_many :kudos_received, class_name: "Kudo", foreign_key: :receiver_id

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
