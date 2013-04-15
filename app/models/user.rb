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

  def thanks(attrs)
    # TODO manual - rewrite
    _attrs = {
        value: attrs["value"],
        comment: attrs["comment"],
        receiver_id: attrs["receiver_id"]
    }
    kudo = current_weekly_kudo.kudos.build(_attrs)
    kudo.save!
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
        kudos_total_received: current_weekly_kudo.up_to_last_week_total_kudos_received,
        trend: 'steady',

        # TODO hack because of ember.js model inheritance
        kudos_received: [],
        kudos_last_week: []
    }
  end

  def ember_user_info
    {
        id: id,
        name: name,
        email: email
    }
  end

  def ember_user_info_for_current_user(user)
    {
        id: id,
        name: name,
        email: email,
        kudos_received_ids: [],
        kudos_last_week_ids: []
    }
  end

  #kudosReceived: kudos_for_week_and_from_user(Week::Info.current, user).map(&:ember_kudo_info),
  #kudosLastWeek: kudos_for_week_and_from_user(Week::Info.previous, user).map(&:ember_kudo_info)
  #def kudos_for_week_and_from_user(week, user)
  #  kudos_received.joins(:weekly_kudo => :week).
  #      where(weeks: {number: week.id},
  #            weekly_kudos: {user_id: user.id})
  #end
end
