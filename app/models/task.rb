class Task < ActiveRecord::Base

  belongs_to :project

  validates_presence_of :name, :due_on
  
  # Validates that due date for task cannot be in the past
  validates_each :due_on, :on => :create do |record, attribute, value| 
    record.errors.add(attribute, 'date cannot be in the past') if value.to_time < Date.today.to_time
  end
  
  named_scope :all_ordered, :order => 'due_on ASC'
  named_scope :all_completed, :conditions => { :completed => true }
  named_scope :recently_completed, :order => 'completed_at DESC', :limit => 15
  
  before_save :set_completed_at
  
  private
  
  # Set completed_at to current time for just completed record, otherwise to nil
  def set_completed_at
    self.completed_at = self.completed? ? Time.now.utc : nil
  end
  
end
