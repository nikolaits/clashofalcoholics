class SetDefaulLevelValue < ActiveRecord::Migration
  def change
  	change_column :district_buildings, :level, :int, default: 0
  end
end
