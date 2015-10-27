class District < ActiveRecord::Base
	District.has_many :district_buildings
	District.belongs_to :user
end