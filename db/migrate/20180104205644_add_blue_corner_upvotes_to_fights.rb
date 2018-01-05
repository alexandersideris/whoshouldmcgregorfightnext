class AddBlueCornerUpvotesToFights < ActiveRecord::Migration
  def change
    add_column :fights, :blue_corner_upvotes, :integer
  end
end
