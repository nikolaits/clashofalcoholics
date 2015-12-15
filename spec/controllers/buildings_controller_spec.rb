require 'rails_helper'
RSpec.describe BuildingsController, type: :controller do
  describe 'POST /buildings/upgrade' do
    before :each do
      @distr = create(:district, beer: 100, food: 100, vodka: 100, stone: 0)
      @usr = @distr.user
      @build = create(:building)\
    end

    it "returns an error when building doesn't not exists" do
      post :upgrade, building_id: 200, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it "returns an error if user doesn't have enough rosources for upgrade" do
      @distr.beer = 0
      @distr.save
      create(:building_level, building_id: @build.id, level: 1, vodka: 10, food: 10, beer: 10)

      post :upgrade, building_id: @build.id, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it 'returns an error if maximum level reached' do
      create(:district_building, district_id: @distr.id, level: 1)
      create(:building_level, building_id: @build.id, level: 1, vodka: 10, food: 10, beer: 10)

      post :upgrade, building_id: @build.id, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it 'creates a new building record' do
      create(:building_level, building_id: @build.id, level: 1, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: @build.id, format: 'json'
      expect(DistrictBuilding.where(district_id: 1, building_id: @build.id).first.level).to eq(1)
    end

    it 'increments building level of existing building' do
      create(:district_building, district_id: @distr.id, building_id: @build.id, level: 1)
      create(:building_level, building_id: @build.id, level: 2, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: @build.id, format: 'json'
      expect(DistrictBuilding.where(district_id: 1, building_id: @build.id).first.level).to eq(2)
    end

    it 'subtracts resources from district' do
      create(:district_building, district_id: @distr.id, building_id: @build.id, level: 1)
      create(:building_level, building_id: @build.id, level: 2, vodka: 10, food: 10, beer: 10, stone: 0)

      post :upgrade, building_id: @build.id, format: 'json'
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
