class BuildingsController < ApplicationController
  def upgrade
    # pp params
    # render template: "buildings/upgrade.json"
    @error = false

    begin
      Building.find(params['building_id'])
    rescue
      @error = true
    end
  end
end
