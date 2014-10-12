class CreateRants < ActiveRecord::Migration
  def change
    create_table :rants do |t|
      t.string :topic
      t.string :details
      t.integer :user_id
      t.timestamps
    end
  end
end
