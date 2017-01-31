require 'active_record'

class TestZone < ActiveRecord::Base
  has_many :mob_groups
  validates :name,
            presence: true
end
