require 'sinatra'
require_relative 'zone_model'
require_relative 'environment'

get '/api/zones' do
  Zone.all.to_json
end

get '/api/zones/:id' do |id|
  Zone.where("zones.id = #{id}").to_json
end
