module TasksHelper
  
  def css_class_for_task(task)
    out  = ''
    out += 'completed' if task.completed?
    return out
  end
  
end
