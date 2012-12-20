class AddModelIdToTrim < ActiveRecord::Migration
  def change
    add_column :trims, :model_id, :integer
  end
end
