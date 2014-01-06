class Week < ActiveRecord::Base
  attr_accessible :end_at, :number, :start_at, :fusion

  belongs_to :fusion
  has_many :weekly_kudos
  has_many :kudos, through: :weekly_kudos

  validates_presence_of :start_at, :end_at, :number, :fusion_id

  def self.current
    week = Info.current
    where(number: week.id).first ||
        create(week.attrs)
  end

  def self.previous
    week = Info.previous
    where(number: week.id).first
  end

  def self.ensure_each_user_have_weekly_kudos_created_for_week(week)
    if User.count > week.weekly_kudos.count
      User.all.each do |user|
        WeeklyKudo.current(user, week)
      end
    end
  end

  def top_kudos_collectors
    self.class.ensure_each_user_have_weekly_kudos_created_for_week(self)
    receivers = []
    kudos.without_retired.includes(:receiver).all.group_by(&:receiver).each_pair do |receiver, kudos|
      receivers << [kudos.sum(&:value), receiver]
    end
    receivers.sort_by(&:first).reverse[0..2].map(&:last).compact
  end

  def top_kudos_hamsters
    self.class.ensure_each_user_have_weekly_kudos_created_for_week(self)
    weekly_kudos.without_retired.where("kudos_left > 8").order("kudos_left DESC").includes(:user).limit(3).map(&:user).compact
  end

  def previous
    week = Info.new(end_at.to_datetime - 7.days)
    Week.where(number: week.id).first
  end

  def name
    [number, start_at.to_date.to_s(:short)].join(" - ")
  end

  class Info
    def self.current
      new(DateTime.now.utc.end_of_week)
    end

    def self.previous
      new(DateTime.now.utc.end_of_week - 7.days)
    end

    def initialize(time)
      @time = time
    end

    def attrs
      {number: id, start_at: start_at, end_at: end_at, fusion: Fusion.current}
    end

    attr_reader :time

    def id
      "#{time.year}#{"%02d" % time.cweek}"
    end

    def start_at
      time.beginning_of_week
    end

    def end_at
      time.end_of_week
    end
  end
end
