class ChangeDetailsToText < ActiveRecord::Migration
  def up
    change_column :rants, :details, :text
  end

  def down
    change_column :rants, :details, :string
  end


end
