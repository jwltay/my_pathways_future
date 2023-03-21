class CareersController < ApplicationController
  def index
    @careers = Career.all
  end

  def show
    @career = Career.find(params[:id])
  end

  def new
    @career = Career.new
  end

  def create
    @career = Career.new(job_params)
    @career.user = current_user
    if @career.save
      redirect_to career_path(@career)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @career = Career.find(params[:id])
  end

  def update
    @careere = Career.find(params[:id])
    @career.update!(career_params)
    redirect to career_path(current_user)
  end

  private

  def career_params
    params.require(:career).permit(:average_salary, :description, :name, :summary)
  end
end
