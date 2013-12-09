class AddContactEmailToEvents < ActiveRecord::Migration
  def change
    add_column :events, :contactEmail, :string
  end
end
