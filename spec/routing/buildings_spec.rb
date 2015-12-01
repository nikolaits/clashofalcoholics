require 'rails_helper'
RSpec.describe 'Buildings routes', type: :routing do
  it 'routes /buildings/upgrade to buildings#upgrade' do
    expect(post('/buildings/upgrade')).to route_to('buildings#upgrade')
  end

  it 'routes /buildings/list to buildings#list' do
    expect(get('/buildings/list')).to route_to('buildings#list')
  end
end
