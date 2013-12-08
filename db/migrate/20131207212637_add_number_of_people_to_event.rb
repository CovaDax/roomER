class AddNumberOfPeopleToEvent < ActiveRecord::Migration
  def change
    add_column :events, :number, :integer
  end
end
