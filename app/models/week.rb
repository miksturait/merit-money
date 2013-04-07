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


  def previous
    # TOOD - weird ...
    last_week_date =  DateTime.parse(start_at.to_s) - 7.days
    week = Info.new(last_week_date)
    Week.where(number: week.id).first
  end

  class Info
    def self.current
      new(DateTime.now.utc)
    end

    def self.previous
      new(DateTime.now.utc - 7.days)
    end

    def attrs
      { number: id, start_at: start_at, end_at: end_at, fusion: Fusion.current }
    end

    def initialize(time)
      @time = time
    end

    def id
      "#{@time.year}#{"%02d" % @time.cweek}"
    end

    def start_at
      @time.beginning_of_week
    end

    def end_at
      @time.end_of_week
    end
  end
end
