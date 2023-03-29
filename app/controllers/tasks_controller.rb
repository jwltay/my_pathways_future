class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    @task.update!(task_params)

    respond_to do |f|
      f.html { redirect_to root_path }
      f.json
    end
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
