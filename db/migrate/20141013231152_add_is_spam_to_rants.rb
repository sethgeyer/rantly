class AddIsSpamToRants < ActiveRecord::Migration
  def change
    add_column :rants, :shown, :boolean, default: true
  end
end
