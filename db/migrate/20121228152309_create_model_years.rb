class CreateModelYears < ActiveRecord::Migration
  def change
    create_table :model_years do |t|
      t.string :year
      t.string :edmunds_id
      t.integer :model_id

      t.timestamps
    end
  end
end
