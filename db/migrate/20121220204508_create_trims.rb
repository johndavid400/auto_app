class CreateTrims < ActiveRecord::Migration
  def change
    create_table :trims do |t|
      t.string :name

      t.timestamps
    end
  end
end
