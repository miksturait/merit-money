class AddFusionIdToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :fusion_id, :integer
    add_index :weeks, :fusion_id
  end
end
