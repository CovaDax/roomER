class AddContactPhoneToEvents < ActiveRecord::Migration
  def change
    add_column :events, :contactPhone, :string
  end
end
