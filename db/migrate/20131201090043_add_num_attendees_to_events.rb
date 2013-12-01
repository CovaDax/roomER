class AddNumAttendeesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :numAttendees, :integer
  end
end
