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
