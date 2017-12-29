class AddIsUpdatedToFighters < ActiveRecord::Migration
  def change
    add_column :fighters, :is_updated, :string
  end
end
