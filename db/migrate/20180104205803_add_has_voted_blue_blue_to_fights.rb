class AddHasVotedBlueBlueToFights < ActiveRecord::Migration
  def change
    add_column :fights, :has_voted_blue_corner, :integer
  end
end
