class WeeklyKudo < ActiveRecord::Base
  attr_accessible :hours_worked, :kudos_left,
                  :last_week_kudos_received, :up_to_last_week_total_kudos_received,
                  :week, :user


  belongs_to :user
  def giver; user; end

  belongs_to :week
  has_many :kudos

  validates_presence_of :user_id, :week_id
  validates_inclusion_of :kudos_left, in: 0..20

  def self.current(user)
    week = Week.current
    where(week_id: week.id, user_id: user.id).first ||
        create(compute_attrs(week: week, user: user))
  end

  # TODO - refactor as separte object (calculation of params)
  def self.current_week_attrs
    defaults = {
        hours_worked: nil,
        kudos_left: 20
    }
    # TODO - in BackEnd-2#sks-3
    up_to_last_week_stats = {
        last_week_kudos_received: 0,
        up_to_last_week_total_kudos_received: 0
    }
  end

  def self.compute_attrs(attrs)
    current_week_attrs.merge(attrs)
  end
end
