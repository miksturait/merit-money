class WeeklyKudo < ActiveRecord::Base
  attr_accessible :hours_worked, :kudos_left,
                  :last_week_kudos_received, :up_to_last_week_total_kudos_received,
                  :week, :user


  belongs_to :user

  def giver;
    user;
  end

  belongs_to :week
  has_many :kudos

  validates_presence_of :user_id, :week_id
  validates_inclusion_of :kudos_left, in: 0..20

  def self.current(user, week = Week.current)
    where(week_id: week.id, user_id: user.id).first ||
        create(ComputeAttrs.new(week, user).to_param)
  end

  class ComputeAttrs < Struct.new(:week, :user)
    def to_param
      defaults.merge({last_week_kudos_received: last_week_kudos_received,
                      up_to_last_week_total_kudos_received: up_to_last_week_total_kudos_received,
                      week: week,
                      user: user})
    end

    private

    def last_week_kudos_received
      if previous_week
        @last_week_kudos_received ||=
            previous_week.kudos.where(receiver_id: user.id).sum(:value)
      else
        0
      end
    end

    def up_to_last_week_total_kudos_received
      if previous_week && previous_weekly_kudo = WeeklyKudo.where(week_id: previous_week.id, user_id: user.id).first
        previous_weekly_kudo.up_to_last_week_total_kudos_received + last_week_kudos_received
      else
        0
      end
    end

    def previous_week
      @previous_week ||= week.previous
    end

    def defaults
      {
          hours_worked: nil,
          kudos_left: 20
      }
    end
  end
end
