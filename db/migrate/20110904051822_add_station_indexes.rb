class AddStationIndexes < ActiveRecord::Migration
  def up
    add_index "stations", ["name"], :name => "station_name_index", :unique => true
    add_index "stations", ["cta_id"], :name => "station_id_index", :unique => true
  end

  def down
    #remove_index(table_name, :column => column_name)
    remove_index "stations", :name => "station_name_index"
    remove_index "stations", :name => "station_id_index"
  end
end
