class ChangeColumnNamesInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :content_id, :remark_id
    rename_column :comments, :content_type, :remark_type
  end
end
