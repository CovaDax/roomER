class AddContacttoEvent < ActiveRecord::Migration
  def up
    add_column :events, :contactName, :string
    add_column :events, :email, :string
    rename_column :events, :number, :numAttends
    rename_column :events, :name, :eventName

  end

  def down
    remove_column :events, :contactName
    remove_column :events, :email
    rename_column :events, :numAttends, :number
    rename_column :events, :eventName, :name
  end
end
