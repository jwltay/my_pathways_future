class ProgrammesController < ApplicationController
  def index
    @user = current_user
    @pathways = Pathway.where(user: @user) #when fixed, used @user.pathways instead
    @programmes = @pathways.map do |pathway|
      pathway.programme
    end
  end

  def show
    @programme = Programme.find(params[:id])
  end

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
