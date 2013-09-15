class Fusion < ActiveRecord::Base
  attr_accessible :end_at, :start_at, :total_fusion_budget, :total_working_hours

  has_many :weeks
  validates_inclusion_of :total_fusion_budget, in: 40_000..80_000, allow_nil: true
  validates_presence_of :start_at


  def self.current
    date = DateTime.now.utc
    # WHY, squeel doesn't work even that included :-(
    # where{(start_at.lteq date) & ((end_at = nil) | (end_at.gteq date)) }
    where(["start_at <= ? AND (end_at is NULL OR end_at >= ?)", date, date]).first ||
        create(Info.new(date).attrs)
  end

  def self.previous
    order("end_at DESC").first
  end

  def name
    "#{start_at} - #{end_at||'...'}"
  end

  class Info
    def initialize(date)
      @date = date
    end

    def attrs
      {
          start_at: start_at
      }
    end

    private

    def start_at
      if previous = Fusion.previous
        previous.end_at + 1.second
      else
        @date.beginning_of_week
      end
    end
  end
end
