class AddCompletedAtColumnToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :completed_at, :datetime
  end

  def self.down
    remove_column :tasks, :completed_at
  end
end
