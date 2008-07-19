class Task < ActiveRecord::Base

  validates_presence_of :name, :due_on
  
  # Validates that due date for task cannot be in the past
  validates_each :due_on, :on => :create do |record, attribute, value| 
    record.errors.add(attribute, 'date cannot be in the past') if value.to_time < Date.today.to_time
  end
  
end
