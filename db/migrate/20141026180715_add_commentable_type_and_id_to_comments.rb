class AddCommentableTypeAndIdToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :rant_id, :integer
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end
