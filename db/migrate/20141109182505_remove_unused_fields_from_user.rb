class RemoveUnusedFieldsFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :with_company_since, :days_off_left
    remove_column :fusions, :total_fusion_budget, :total_working_hours
    add_column :users, :outsider, :boolean, default: false
  end

  def down
  end
end
