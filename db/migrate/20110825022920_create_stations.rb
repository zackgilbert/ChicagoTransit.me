class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :cta_id
      t.string :name
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
