class AddImageToModelYears < ActiveRecord::Migration
  def change
    add_column :model_years, :image, :string
  end
end
