class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :cta_id
      t.string :name
      t.string :direction
      t.float :lng
      t.float :lat
      t.string :station_name
      t.integer :station_cta_id
      t.boolean :ada
      t.boolean :red
      t.boolean :blue
      t.boolean :green
      t.boolean :brown
      t.boolean :purple
      t.boolean :purple_express
      t.boolean :yellow
      t.boolean :pink
      t.boolean :orange

      t.timestamps
    end
  end
end
