class RemoveGiverFromKudo < ActiveRecord::Migration
  def change
    remove_column :kudos, :giver_id
  end
end
