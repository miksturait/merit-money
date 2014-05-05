class WeeklyKudo < ActiveRecord::Base
  attr_accessible :hours_worked, :kudos_left,
                  :last_week_kudos_received, :up_to_last_week_total_kudos_received,
                  :week, :user, :trend


  belongs_to :user

  scope :without_retired, joins(:user).where(users: {retired: [nil, false]})

  def giver;
    user;
  end

  belongs_to :week
  has_many :kudos

  validates_presence_of :user_id, :week_id
  validates_inclusion_of :kudos_left, in: 0..60

  def self.current(user, week = Week.current)
    where(week_id: week.id, user_id: user.id).first ||
        create(ComputeAttrs.new(week, user).to_param)
  end

  def name
    [week.name, giver.name].join(" :: ")
  end

  class ComputeAttrs < Struct.new(:week, :user)
    def to_param
      defaults.merge({last_week_kudos_received: last_week_kudos_received,
                      up_to_last_week_total_kudos_received: up_to_last_week_total_kudos_received,
                      week: week,
                      user: user,
                      kudos_left: kudos_left,
                      trend: trend})
    end

    private


    def trend
      previous_weekly_kudos = user.weekly_kudos.where(["week_id < ?", week.id]).order("week_id DESC").limit(2)
      if previous_weekly_kudos.any?

        total_kudos = previous_weekly_kudos.sum(&:last_week_kudos_received)
        total_weeks = previous_weekly_kudos.size
        average = total_kudos / total_weeks

        if last_week_kudos_received > average
          "upward"
        elsif last_week_kudos_received < average
          "downward"
        else
          "steady"
        end
      else
        "steady"
      end
    end

    def last_week_kudos_received
      if previous_week
        @last_week_kudos_received ||=
            previous_week.kudos.where(receiver_id: user.id).sum(:value)
      else
        0
      end
    end

    def up_to_last_week_total_kudos_received
      if previous_week && (previous_weekly_kudo = WeeklyKudo.where(week_id: previous_week.id, user_id: user.id).first)
        previous_weekly_kudo.up_to_last_week_total_kudos_received + last_week_kudos_received
      else
        0
      end
    end

    def previous_week
      @previous_week ||= week.previous
    end

    def kudos_left
      user.default_weekly_kudos || 20
    end

    def defaults
      {
          hours_worked: nil
      }
    end
  end
end
