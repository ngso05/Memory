class RemoveNameFromTagMaps < ActiveRecord::Migration[5.2]
  def change
    remove_column :tag_maps, :name, :string
  end
end
