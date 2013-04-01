class AddWeeklyKudoRelationToKudo < ActiveRecord::Migration
  def change
    add_column :kudos, :weekly_kudo_id, :integer
  end
end
