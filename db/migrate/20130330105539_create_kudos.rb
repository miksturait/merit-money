class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.integer :value, default: 1
      t.text :comment
      t.belongs_to :giver
      t.belongs_to :receiver

      t.timestamps
    end
    add_index :kudos, :giver_id
    add_index :kudos, :receiver_id
  end
end
