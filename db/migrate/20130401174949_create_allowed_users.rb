
class CreateAllowedUsers < ActiveRecord::Migration
  def change
    create_table :allowed_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
