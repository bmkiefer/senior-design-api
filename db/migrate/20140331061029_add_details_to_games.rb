class AddDetailsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_organization, :string
    add_column :games, :away_organization, :string
    add_column :games, :sport, :string
    add_column :games, :date, :datetime
  end
end
