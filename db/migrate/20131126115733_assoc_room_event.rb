class AssocRoomEvent < ActiveRecord::Migration
  def change
  	add_column :rooms, :event_id, :integer   #add to table Rooms
  	add_column :events, :room_id, :integer   #add to table Events
  end
end
