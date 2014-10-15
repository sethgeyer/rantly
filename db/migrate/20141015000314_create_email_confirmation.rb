class CreateEmailConfirmation < ActiveRecord::Migration
  def change
    create_table :email_confirmers do |t|
      t.integer :user_id
      t.string :confirmation_token
    end
  end
end
