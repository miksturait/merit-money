class AddDefaultWeeklyKudosToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_weekly_kudos, :integer, default: nil
  end
end
