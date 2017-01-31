require 'sinatra'
require_relative '../model/model'
require_relative 'environment'

after do
  ActiveRecord::Base.connection.close
end

get '/api/zones' do
  TestZone.all.to_json
end

get '/api/zones/:id' do |id|
  if zone_exists?({'id' => id})
    TestZone.where('test_zones.id = ?', id).to_json
  else
    status 404
  end
end

post '/api/zones' do
  if zone_exists?(params)
    zone = TestZone.create(params)
    status 201
    zone.to_json
  else
    status 400
  end
end

put '/api/zones' do
  TestZone.update(params['id'], params)
end

delete '/api/zones/:id' do |id|
  TestZone.destroy(id)
end

def zone_exists?(zone)
  TestZone.new(zone).valid? or not(TestZone.find_by(id: zone['id']).nil?)
end
