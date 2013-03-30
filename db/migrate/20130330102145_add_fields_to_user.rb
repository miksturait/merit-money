class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :with_company_since, :date
    add_column :users, :days_off_left, :integer, default: 0
  end
end
