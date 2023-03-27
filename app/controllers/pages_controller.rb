class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to :dashboard if current_user
  end

  def dashboard
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    # For a monthly view:
    # @meetings = Meeting.where(starts_at: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
