require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  fixtures :tasks, :projects
  
  def test_task_should_be_invalid_when_date_is_in_the_past
    t = Task.new :name => 'Test yesterday', :due_on => 1.day.ago
    assert !t.valid?, "Task should be invalid when due_on is in the past"
  end
    
  def test_task_should_belong_to_proper_project
    assert_equal tasks(:milk).project, projects(:home)
  end

end
