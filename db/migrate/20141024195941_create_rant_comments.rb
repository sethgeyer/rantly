class CreateRantComments < ActiveRecord::Migration
  def change
    create_table :rant_comments do |t|
        t.text :body
        t.integer :rant_id
    end
  end
end
