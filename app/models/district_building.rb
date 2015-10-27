class DistrictBuilding < ActiveRecord::Base
	belongs_to :district
	belongs_to :building
end