module TasksHelper
  
  # Return CSS class(es) for task, eg. "completed" for completed tasks
  def css_class_for_task(task)
    out  = ''
    out += 'completed' if task.completed?
    return out
  end
  
end
