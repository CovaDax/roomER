class ChangeEventNameToName < ActiveRecord::Migration
  def up
    rename_column :events, :eventName, :name
  end

  def down
    rename_column :events, :name, :eventName
  end
end
