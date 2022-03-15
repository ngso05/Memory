class AddTagIdToTagMaps < ActiveRecord::Migration[5.2]
  def change
    add_column :tag_maps, :tag_id, :integer
  end
end
