class CreateFusions < ActiveRecord::Migration
  def change
    create_table :fusions do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :total_working_hours
      t.integer :total_fusion_budget

      t.timestamps
    end
  end
end
