class AddEventNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :eventName, :string
  end
end
