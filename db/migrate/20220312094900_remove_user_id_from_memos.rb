class RemoveUserIdFromMemos < ActiveRecord::Migration[5.2]
  def change
    remove_column :memos, :user, :integer
  end
end
