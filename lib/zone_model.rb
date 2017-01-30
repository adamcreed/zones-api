require 'active_record'

class Zone < ActiveRecord::Base
  has_many :mob_groups
  validates :id,
            :zone_type,
            :zone_ip,
            :zone_port,
            :name,
            :music_day,
            :music_night,
            :battle_solo,
            :battle_multi,
            :restriction,
            :tax,
            :misc,
            presence: true

  self.primary_key = 'id'          
end
