class AddHoursPerWeekToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :hours_per_week, :integer, :default => 35, :null => false
  end

  def self.down
    remove_column :users, :hours_per_week
  end

end
