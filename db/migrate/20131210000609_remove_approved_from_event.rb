class RemoveApprovedFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :approved
  end

  def down
    add_column :events, :approved, :boolean
  end
end
