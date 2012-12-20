class AddMakeIdToModel < ActiveRecord::Migration
  def change
    add_column :models, :make_id, :integer
  end
end
