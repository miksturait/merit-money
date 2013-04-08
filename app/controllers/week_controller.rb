class WeekController < ApplicationController
  before_filter :authenticate_user!

  def top_collectors
    render json: { users: week.top_kudos_collectors.map(&:ember_user_info) }
  end

  def top_hamsters
    render json: { users: week.top_kudos_hamsters.map(&:ember_user_info)}
  end

  private

  def week
    @week ||= Week.previous
  end
end
