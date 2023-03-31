class ProgrammesController < ApplicationController
  def index
    @user = current_user
    @career = Career.find(params[:career_id])
    @programmes = @career.programmes
    @programmes_even = @programmes.each_with_index.filter_map { |p, i| p if i.even? }
    @programmes_odd = @programmes.each_with_index.filter_map { |p, i| p if i.odd? }
  end

  def show
    @programme = Programme.find(params[:id])
  end

  # def shortlist
  #   # get the programme
  #   @programme = Programme.find(params[:programme_id])

  #   # create a new pathway
  #   @pathway = Pathway.new
  #   @pathway.programme = @programme
  #   @pathway.user = current_user
  #   @pathway.shortlist = true

  #   @pathway.save
  # end

  # def new
  #   @programme = Programme.new
  # end

  # def create
  #   @programme = Programme.new(job_params)
  #   @programme.user = current_user
  #   if @programme.save
  #     redirect_to programme_path(@programme)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def edit
  #   @programme = Programme.find(params[:id])
  # end

  # def update
  #   @programme = Programme.find(params[:id])
  #   @programme.update!(programme_params)
  #   redirect to programme_path(current_user)
  # end

  # def delete
  # end

  # private

  # def programme_params
  #   params.require(:programme).permit(:tuition_fees, :duration, :rating, :description, :summary)
  # end
end
