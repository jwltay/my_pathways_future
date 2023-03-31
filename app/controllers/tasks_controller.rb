class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @tasks = Task.all.order(id: :asc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    respond_to do |format|
      if @task.save
        format.html { redirect_to dashboard_path }
      else
        format.html { render "pages/dashboard", status: :unprocessable_entity }
      end
      format.json
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

    respond_to do |format|
      # format.html { redirect_to dashboard_path, status: :see_other }
      format.json { render json: { task: @task.persisted?, status: :see_other } }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
