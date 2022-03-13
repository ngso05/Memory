class RemoveUserIdFromTagMaps < ActiveRecord::Migration[5.2]
  def change
    remove_column :tag_maps, :user_id, :integer
  end
end
