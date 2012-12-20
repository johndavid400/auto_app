class AddEdmundsMakeIdToMakes < ActiveRecord::Migration
  def change
    add_column :makes, :edmunds_make_id, :string
  end
end
