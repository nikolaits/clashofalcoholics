class BuildingsController < ApplicationController
  before_action :find_user

  def upgrade
    @error = false

    begin
      Building.find(params[:building_id])
    rescue
      @error = true
      return
    end

    # Get next level of building
    building = DistrictBuilding.find_or_create_by(district_id: @district.id, building_id: params[:building_id])
    building.level += 1

    requirements = BuildingLevel.where(building_id: params[:building_id], level: building.level).first
    unless requirements
      @error = true
      return
    end

    if requirements && (requirements.beer > @district.beer || requirements.vodka > @district.vodka || requirements.food > @district.food || requirements.stone > @district.stone)
      @error = true
      return
    end

    building.save

    # Subtract resources
    @district.beer -= requirements.beer
    @district.food -= requirements.food
    @district.vodka -= requirements.vodka
    @district.stone -= requirements.stone
    @district.save
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
