require 'rails_helper'
RSpec.describe BuildingsController, type: :controller do
  describe 'POST /buildings/upgrade' do
    it "returns an error when building doesn't not exists" do
      post :upgrade, building_id: 200, format: 'json'
      error = assigns(:error)
      expect(error).to eq(true)
    end

    it "returns an error if user doens't have enought rosources for upgrade" do
      @usr = User.create(id: '1')
      District.create(user_id: '1')

      pp @usr.districts
    end
  end
end
