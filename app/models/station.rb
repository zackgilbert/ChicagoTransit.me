class Station < ActiveRecord::Base
  has_many :stops, :primary_key => "cta_id", :foreign_key => "station_cta_id"
end
