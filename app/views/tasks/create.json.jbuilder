if @task.persisted?
  json.form render(partial: "pages/todo_list_form", formats: :html, locals: {user: @user, task: Task.new})
  json.inserted_item render(partial: "pages/task", formats: :html, locals: {task: @task})
else
  # json.form render(partial: "reviews/form", formats: :html, locals: {restaurant: @restaurant, review: @review})
  json.form render('pages/dashboard')
end
