class AddEdmundsIdOnModels < ActiveRecord::Migration
  def change
    add_column :models, :edmunds_id, :string
  end
end
