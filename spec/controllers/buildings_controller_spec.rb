require 'rails_helper'
RSpec.describe BuildingsController, type: :controller do
  describe 'POST /buildings/upgrade' do
    it "returns an error when building doesn't not exists" do
      User.create(id: 1)

      post :upgrade, building_id: 200, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it "returns an error if user doesn't have enough rosources for upgrade" do
      @usr = User.create(id: 1)
      District.create(user_id: 1, beer: 0, food: 0, vodka: 0, stone: 0)
      Building.create(id: 1)
      BuildingLevel.create(building_id: 1, level: 1, vodka: 10, food: 10, beer: 10)

      post :upgrade, building_id: 1, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it 'returns an error if maximum level reached' do
      @usr = User.create(id: 1)
      District.create(user_id: 1, beer: 0, food: 0, vodka: 0, stone: 0)
      Building.create(id: 1)
      DistrictBuilding.create(district_id: 1, level: 1)
      BuildingLevel.create(building_id: 1, level: 1, vodka: 10, food: 10, beer: 10)

      post :upgrade, building_id: 1, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it 'creates a new building record' do
      @usr = User.create(id: 1)
      District.create(user_id: 1, beer: 100, food: 100, vodka: 100, stone: 0)
      Building.create(id: 1)
      BuildingLevel.create(building_id: 1, level: 1, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: 1, format: 'json'

      expect(DistrictBuilding.where(district_id: 1, building_id: 1).first.level).to eq(1)
    end

    it 'increments building level of existing building' do
      @usr = User.create(id: 1)
      District.create(user_id: 1, beer: 100, food: 100, vodka: 100, stone: 0)
      Building.create(id: 1)
      DistrictBuilding.create(district_id: 1, building_id: 1, level: 1)
      BuildingLevel.create(building_id: 1, level: 2, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: 1, format: 'json'

      expect(DistrictBuilding.where(district_id: 1, building_id: 1).first.level).to eq(2)
    end

    it 'subtracts resources from district' do
      @usr = User.create(id: 1)
      District.create(user_id: 1, beer: 100, food: 100, vodka: 100, stone: 0)
      Building.create(id: 1)
      DistrictBuilding.create(district_id: 1, building_id: 1, level: 1)
      BuildingLevel.create(building_id: 1, level: 2, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: 1, format: 'json'
      district = District.all.first

      expect(district.beer).to eq(90)
      expect(district.food).to eq(90)
      expect(district.vodka).to eq(90)
      expect(district.stone).to eq(0)
    end
  end

  describe 'GET /buildings/levels' do
    it 'returns a list of building levels' do
      User.create(id: 1)

      Building.create(id: 10)
      10.times do |i|
        BuildingLevel.create(building_id: 10, level: i + 1)
      end

      get :levels, building_id: 10, format: 'json'

      levels = assigns(:levels)
      expect(levels.length).to eq(10)
    end
  end
end
