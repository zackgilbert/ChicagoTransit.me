class Stop < ActiveRecord::Base
  belongs_to :station, :primary_key => "cta_id", :foreign_key => "station_cta_id"
end
