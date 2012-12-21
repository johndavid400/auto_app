class ChangeEdmundsMakeIdToEdmundsIdOnMakes < ActiveRecord::Migration
  def change
    rename_column :makes, :edmunds_make_id, :edmunds_id
  end
end
