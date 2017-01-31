require_relative '../lib/environment'
require_relative '../model/model'
require 'csv'

class Seed
  def self.seed
    CSV.foreach('data/zones') do |row|
      zone = TestZone.create(
      id:           row[0],
      zone_type:    row[1],
      zone_ip:      row[2],
      zone_port:    row[3],
      name:         row[4],
      music_day:    row[5],
      music_night:  row[6],
      battle_solo:  row[7],
      battle_multi: row[8],
      restriction:  row[9],
      tax:          row[10],
      misc:         row[11]
      )
    end

    sql = 'ALTER SEQUENCE test_zones_id_seq RESTART WITH ' + (TestZone.all.count).to_s
    ActiveRecord::Base.connection.execute(sql)
  end
end

seed if __FILE__ == $PROGRAM_NAME
