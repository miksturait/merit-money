class WeeklyKudo < ActiveRecord::Base
  attr_accessible :hours_worked, :kudos_left, :last_week_kudos_received, :up_to_last_week_total_kudos_received

  belongs_to :user
  def giver; user; end

  belongs_to :week
  has_many :kudos

  validates_presence_of :user_id, :week_id
  validates_inclusion_of :kudos_left, in: 0..20
end
