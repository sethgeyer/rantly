class AddContentTypeAndIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :content_type, :string
    add_column :comments, :content_id, :integer
  end
end
