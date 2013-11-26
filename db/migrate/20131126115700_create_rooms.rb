class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :building
      t.integer :number
      t.integer :maxOccupancy

      t.timestamps
    end
  end
end
