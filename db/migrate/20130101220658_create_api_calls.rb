class CreateApiCalls < ActiveRecord::Migration
  def change
    create_table :api_calls do |t|

      t.timestamps
    end
  end
end
