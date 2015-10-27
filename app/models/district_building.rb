class DistrictBuilding < ActiveRecord::Base
	belongs_to :building
	belongs_to :district
end