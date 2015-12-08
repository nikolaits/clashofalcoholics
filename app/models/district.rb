class District < ActiveRecord::Base
  belongs_to :user
  has_many :district_buildings
end
