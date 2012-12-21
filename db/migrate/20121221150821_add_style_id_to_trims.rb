class AddStyleIdToTrims < ActiveRecord::Migration
  def change
    add_column :trims, :style_id, :string
  end
end
