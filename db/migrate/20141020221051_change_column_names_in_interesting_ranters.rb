class ChangeColumnNamesInInterestingRanters < ActiveRecord::Migration
  def change
    rename_column :interesting_ranters, :user_id, :follower_id
    rename_column :interesting_ranters, :person_id, :followed_user_id
  end
end
