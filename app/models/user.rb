class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email,
                  :with_company_since,
                  :days_off_left

  has_many :weekly_kudos
  has_many :kudos, through: :weekly_kudos
  has_many :kudos_received, class_name: "Kudo", foreign_key: :receiver_id

  scope :order_by_last_week_kudos_distribution_asc, ->(user) {
    last_two_weekly_kudos = WeeklyKudo.where(week_id: [Week.try(:previous).try(:id),
                                                       Week.try(:previous).try(:previous).try(:id)],
                                             user_id: user.id).pluck(:id)

    order_tmp_table = Kudo.where(weekly_kudo_id: last_two_weekly_kudos).group(:receiver_id).select("sum(kudos.value) as kudos, receiver_id as user_id").to_sql
    order_table = User.joins("LEFT JOIN (#{order_tmp_table}) AS users_order ON users_order.user_id=users.id").
        select("users.id AS user_id, coalesce(users_order.kudos, 0) AS kudos").to_sql
    joins("LEFT JOIN (#{order_table}) as users_order ON users_order.user_id = users.id").order("users_order.kudos ASC")
  }

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
        value: attrs["value"] || 1,
        comment: attrs["comment"]
    }
    receiver = User.find(attrs["receiver_id"])
    thanks_to_user(receiver, _attrs)
  end

  def thanks_to_user(user, attrs)
    kudo = current_weekly_kudo.kudos.build(attrs)
    kudo.receiver = user
    kudo.save
    kudo
  end

  def kudos_given_by_user_in_week(user, week)
    kudos_received.latest_first.joins(:weekly_kudo).where(weekly_kudos: {week_id: week, user_id: user})
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
        trend: current_weekly_kudo.trend
    }
  end

  def ember_user_info
    {
        id: id,
        name: name,
        email: email
    }
  end

  def ember_user_info_for_current_user
    {
        id: id,
        name: name,
        email: email
    }
  end

  def ember_users_for_me
    users = []
    kudos_received = []
    kudos_last_week = []

    User.where(["users.id != ?", self.id]).order_by_last_week_kudos_distribution_asc(self).all.each do |user|
      _kudos_received = user.kudos_given_by_user_in_week(self, Week.current)
      _kudos_last_week = user.kudos_given_by_user_in_week(self, Week.previous)

      users << user.ember_user_info_for_current_user.merge(
          {
              kudo_received_ids: _kudos_received.map(&:id),
              kudo_last_week_ids: _kudos_last_week.map(&:id)
          }
      )

      kudos_received += _kudos_received
      kudos_last_week += _kudos_last_week
    end

    {
        users: users,
        kudo_receiveds: kudos_received.map(&:ember_kudo_info),
        kudo_last_weeks: kudos_last_week.map(&:ember_kudo_info)
    }
  end

  def ember_user_for(user_id)
    user = User.where(["users.id != ?", self.id]).find(user_id)

    kudos_received = user.kudos_given_by_user_in_week(self, Week.current)
    kudos_last_week = user.kudos_given_by_user_in_week(self, Week.previous)

    user_info = user.ember_user_info_for_current_user.merge(
        {
            kudo_received_ids: kudos_received.map(&:id),
            kudo_last_week_ids: kudos_last_week.map(&:id)
        }
    )

    {
        user: user_info,
        kudo_receiveds: kudos_received.map(&:ember_kudo_info),
        kudo_last_weeks: kudos_last_week.map(&:ember_kudo_info)
    }
  end

  #kudosReceived: kudos_for_week_and_from_user(Week::Info.current, user).map(&:ember_kudo_info),
  #kudosLastWeek: kudos_for_week_and_from_user(Week::Info.previous, user).map(&:ember_kudo_info)
  #def kudos_for_week_and_from_user(week, user)
  #  kudos_received.joins(:weekly_kudo => :week).
  #      where(weeks: {number: week.id},
  #            weekly_kudos: {user_id: user.id})
  #end

  def latest_comments
    kudos_received.with_comment.latest_first.without_kudos_from_current_week.
        limit(50).map(&:ember_comment_info)
  end

  def latest_other_comments
    Week.previous.kudos.with_comment.latest_first.without_received_by(self).map(&:ember_comment_info)
  end
end
