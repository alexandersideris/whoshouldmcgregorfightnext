class CreateFighters < ActiveRecord::Migration
  def change
    create_table :fighters do |t|
      t.string :name
      t.string :division
      t.string :rank
      t.integer :rank_number
      t.string :img_url
      t.string :fight_record
      t.timestamps null: false
    end
  end
end
