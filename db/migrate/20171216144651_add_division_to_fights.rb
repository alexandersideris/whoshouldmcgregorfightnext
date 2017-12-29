class AddDivisionToFights < ActiveRecord::Migration
  def change
    add_column :fights, :division, :string
  end
end
