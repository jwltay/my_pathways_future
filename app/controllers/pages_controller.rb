class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # redirect_to :dashboard if current_user
  end

  def dashboard
    my_programmes = current_user.programmes
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    # Hardcoded countdown for now
    @target = DateTime.new(2023, 4, 2)

    @task = Task.new
    @tasks = current_user.tasks
    # For a monthly view:
    @events = Event.where(
      programme_id: my_programmes,
      start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    )
    @user = current_user
    @programme = @user.pathways.where(primary: true).first.programme
  end
end
