class Game < ActiveRecord::Base
  has_one :home_team
  has_one :away_team
  has_many :game_admins
end
