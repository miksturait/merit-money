class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :number, unique: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end

