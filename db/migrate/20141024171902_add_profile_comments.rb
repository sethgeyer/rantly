class AddProfileComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :body
      t.integer :user_id
    end
  end
end
