class AddIndexToAppearances < ActiveRecord::Migration
  def change
    add_index :appearances, [:user_id, :meetup_id], unique: true
  end
end
