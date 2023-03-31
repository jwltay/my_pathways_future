if @task.persisted?
  json.form render(partial: "pages/todo_list_form", formats: :html, locals: { user: current_user, task: Task.new })
  json.inserted_item render(partial: "pages/task", formats: :html, locals: { task: @task })
else
  json.form render('pages/dashboard')
end
