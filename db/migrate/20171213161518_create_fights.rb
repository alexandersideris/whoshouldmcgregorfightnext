class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|
      t.integer :fighter_one_id
      t.integer :fighter_two_id
      t.integer :upvotes

      t.timestamps null: false
    end
  end
end
