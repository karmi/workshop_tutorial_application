class Project < ActiveRecord::Base
  
  has_many :tasks
  
  validates_presence_of :name
  
  # Returns projects for Rails form select helper
  def self.find_for_select
    self.all.collect { |p| [ p.name, p.id ] }
  end
  
end
