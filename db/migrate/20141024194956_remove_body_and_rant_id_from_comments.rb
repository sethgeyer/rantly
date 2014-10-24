class RemoveBodyAndRantIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :body, :text
    remove_column :comments, :rant_id, :integer
  end
end
