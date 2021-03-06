require_relative '../lib/environment'
require_relative '../model/model'

class CreateTestZonesTable < ActiveRecord::Migration[5.0]

  def up
    create_table :test_zones, id: false do |t|
      t.primary_key :id
      t.integer :zone_type
      t.string :zone_ip
      t.integer :zone_port
      t.string :name
      t.integer :music_day
      t.integer :music_night
      t.integer :battle_solo
      t.integer :battle_multi
      t.integer :restriction
      t.float :tax
      t.integer :misc
    end
  end

  def down
    drop_table :test_zones
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateTestZonesTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
