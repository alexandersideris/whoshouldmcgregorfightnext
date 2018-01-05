class AddRedCornerUpvotesToFights < ActiveRecord::Migration
  def change
    add_column :fights, :red_corner_upvotes, :integer
  end
end
