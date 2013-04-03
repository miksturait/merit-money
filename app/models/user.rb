class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email,
                  :with_company_since,
                  :days_off_left

  has_many :weekly_kudos
  has_many :kudos, through: :weekly_kudos
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

  # TODO - refactor
  def thanks(user, attrs)
    kudo = current_weekly_kudo.kudos.build(attrs)
    kudo.receiver = user
    kudo.save
    kudo
  end

  def current_weekly_kudo
    WeeklyKudo.current(self)
  end

  def ember_current_user_info
    {
        id: id,
        name: name,
        email: email,
        kudos_left: current_weekly_kudo.kudos_left,
        kudos_received: current_weekly_kudo.last_week_kudos_received,
        kudos_total_received: current_weekly_kudo.up_to_last_week_total_kudos_received
    }
  end

  def ember_user_info
    {
        id: id,
        name: name,
        email: email
    }
  end
end
