class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :link
      t.string :description
      t.integer :trim_id

      t.timestamps
    end
  end
end
