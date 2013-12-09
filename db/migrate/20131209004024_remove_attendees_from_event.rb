class RemoveAttendeesFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :numAttendees
  end
end
