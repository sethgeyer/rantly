class DropUserCommentAndRantComment < ActiveRecord::Migration
  def change
    drop_table :user_comments
    drop_table :rant_comments

  end
end
