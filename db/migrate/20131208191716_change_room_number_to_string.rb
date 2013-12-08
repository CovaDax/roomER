class ChangeRoomNumberToString < ActiveRecord::Migration

  def change
    change_column :Rooms, :number, :string
  end

end

