class AddModelIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :model_id, :integer
  end
end
