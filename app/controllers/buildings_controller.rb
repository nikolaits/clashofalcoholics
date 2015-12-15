class BuildingsController < ApplicationController
  before_filter :find_user

  def upgrade
    @error = false

    begin
      Building.find(params[:building_id])
    rescue
      @error = true
    end

    # if !@error
    unless @error
      # Get next level of building
      level = 1
      building = @district.district_buildings.where(params[:building_id]).first
      if building
        level = building.level + 1
      end
      max_building = BuildingLevel.where(building_id: params[:building_id]).order(level: :desc).first;

      if level < max_building.level
        @error=true
      else
        @building.update(level: level)
        @building.save
      end
      if(@error)
        requirements = BuildingLevel.where(building_id: params[:building_id], level: level).first
        if requirements.beer > @district.beer || requirements.vodka > @district.vodka || requirements.food > @district.food || requirements.stone > @district.stone
          @error = true
        else
          if level == 1
            DistrictBuildings.create(district_id: @district.first.id, building_id: params[:building_id], level: level)
          end
        end
      end


    end
  end

  def levels
    @building = Building.find(params[:building_id])
    @levels = @building.levels
  end

  def find_user
    @user = User.all.first
    @district = @user.districts.first
  end
end
