class AddInterestingRanters < ActiveRecord::Migration
  def change
    create_table :interesting_ranters do |t|
      t.integer :user_id
      t.integer :person_id
    end
  end
end
