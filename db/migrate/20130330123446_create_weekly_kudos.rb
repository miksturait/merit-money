class CreateWeeklyKudos < ActiveRecord::Migration
  def change
    create_table :weekly_kudos do |t|
      t.integer :kudos_left, default: 20
      t.integer :last_week_kudos_received
      t.integer :up_to_last_week_total_kudos_received
      t.integer :hours_worked
      t.belongs_to :user
      t.belongs_to :week

      t.timestamps
    end
    add_index :weekly_kudos, :user_id
    add_index :weekly_kudos, :week_id
  end
end
