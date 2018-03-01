class RenameAttendeesAppearances < ActiveRecord::Migration
  def change
    rename_table :attendees, :appearances
  end
end
