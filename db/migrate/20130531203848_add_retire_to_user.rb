class AddRetireToUser < ActiveRecord::Migration
  def change
    add_column :users, :retired, :boolean, default: false
  end
end
