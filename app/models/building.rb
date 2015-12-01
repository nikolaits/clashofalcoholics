class Building < ActiveRecord::Base
  belongs_to :district
  has_many :levels, class_name: BuildingLevel
end
