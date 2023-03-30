class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @tasks = Task.all.order(id: :asc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |f|
      if @task.save
        @tasks = Task.all
        f.html { redirect_to dashboard_path }
        f.json
      else
        f.html { render "pages/todo_list_form", status: :unprocessable_entity }
        f.json
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(task_params)

    respond_to do |f|
      f.html { redirect_to dashboard_path }
      f.json
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to dashboard_path
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
