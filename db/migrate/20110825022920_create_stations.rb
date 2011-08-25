class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :cta_id
      t.string :name

      t.timestamps
    end
  end
end
