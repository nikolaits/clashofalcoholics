class Building < ActiveRecord::Base
	Building.has_many :district_building
end