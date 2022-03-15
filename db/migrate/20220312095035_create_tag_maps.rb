class CreateTagMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_maps do |t|
      t.integer :user_id
      t.integer :memo_id
      t.timestamps
    end
  end
end
