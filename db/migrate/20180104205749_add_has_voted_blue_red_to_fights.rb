class AddHasVotedBlueRedToFights < ActiveRecord::Migration
  def change
    add_column :fights, :has_voted_red_corner, :integer
  end
end
