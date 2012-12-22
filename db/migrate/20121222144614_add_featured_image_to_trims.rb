class AddFeaturedImageToTrims < ActiveRecord::Migration
  def change
    add_column :trims, :featured_image, :string
  end
end
