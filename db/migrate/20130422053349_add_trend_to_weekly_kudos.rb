class AddTrendToWeeklyKudos < ActiveRecord::Migration
  def change
    add_column :weekly_kudos, :trend, :string, default: "steady"
  end
end
