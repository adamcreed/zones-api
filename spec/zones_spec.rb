ENV['RACK_ENV'] = 'test'

require 'zones'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'Zones-API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'zone lookup' do
    it "gets the zone info of the entered ID" do
      get '/api/zones/8'
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body).first['name']).to eq("'Boneyard_Gully'")
    end
  end
end
