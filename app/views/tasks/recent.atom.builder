atom_feed(:url => formatted_tasks_url(:atom)) do |feed|
  feed.title("Tasks")
  feed.link(root_url)
  feed.subtitle('15 recently completed tasks')
  for task in @tasks
    feed.entry(task) do |entry|
      entry.title("#{task.name}")
      entry.content( 
      "Task <strong>#{task.name}</strong> in project <strong>#{task.project.name}</strong> was completed at #{task.completed_at.utc.to_s(:short)}",
      :type => 'html' )
    end
  end
end