class AddEmailIsConfirmedToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_is_confirmed, :boolean, default: false
  end
end
