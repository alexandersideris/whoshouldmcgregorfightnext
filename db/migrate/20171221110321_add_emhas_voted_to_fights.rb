class AddEmhasVotedToFights < ActiveRecord::Migration
  def change
    add_column :fights, :has_voted, :string
  end
end
