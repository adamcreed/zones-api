ENV['RACK_ENV'] = 'test'

require 'zones'
require_relative '../migration/schema'
require_relative '../seed/seeds'
require 'rspec'
require 'rack/test'

describe 'Zones-API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :all do
    CreateTestZonesTable.migrate(:down)
    CreateTestZonesTable.migrate(:up)
    Seed.seed
  end

  describe 'all' do
    it 'returns all zones' do
      get '/api/zones'

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body).size).to eq 294
    end
  end

  describe 'zone lookup' do
    context 'when a valid id is entered' do
      it "gets the zone info of the entered ID" do
        get '/api/zones/8'

        expect(last_response).to be_ok
        expect(JSON.parse(last_response.body).first['name'])
                                             .to eq("'Boneyard_Gully'")
      end
    end

    context 'when an invalid id is entered' do
      it 'returns a 404' do
        get '/api/zones/9999'

        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'add zone' do
    context 'when a zone is successfully added' do
      it 'adds a zone to the database' do
        zone = {name: "Mog_Playhouse"}
        post '/api/zones', zone

        expect(last_response.status).to eq 201
        expect(TestZone.last.name).to eq "Mog_Playhouse"
      end
    end

    context 'when a zone is not added' do
      it 'returns an error' do
        zone = {}
        post '/api/zones', zone

        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'edit zone' do
    it 'edits an existing zone' do
      zone = TestZone.where("name = ?", "'Feretory'").first
      id = zone.id
      music_day = 209

      put '/api/zones', {id: id, music_day: music_day}

      expect(last_response).to be_ok
      expect(TestZone.where("id = #{id}").first.music_day).to eq 209
    end
  end

  describe 'remove zone' do
    it 'removes a zone from the database' do
      zone = TestZone.where("name = ?", "'Valkurm_Dunes'").first
      id = zone.id

      delete "api/zones/#{id}"

      expect(last_response).to be_ok
      expect(TestZone.where("id = #{id}").first).to eq nil
    end
  end
end
