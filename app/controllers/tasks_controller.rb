class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.save

    redirect_to root_path
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
