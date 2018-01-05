class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :fight
      t.integer :user
      t.string :upvoted
      t.string :red_corner
      t.string :blue_corner

      t.timestamps null: false
    end
  end
end
