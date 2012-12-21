class AddSubmodelIdToTrims < ActiveRecord::Migration
  def change
    add_column :trims, :submodel_id, :string
  end
end
