class PathwaysController < ApplicationController
  # before_action :set_programme, except: :update
  # before_action :authenticate_user!

  def index
    @user = current_user
    @pathways = @user.pathways
  end

  # def new
  #   @pathways = Pathway.new
  # end

  # def create
  #   @pathway = Pathway.new(pathway_params)
  #   @pathway.career = @career
  #   @pathway.user = current_user
  #   # current_user.update(user_params)
  #   if @pathway.save
  #     flash[:notice] = "Pathway is saved!"
  #     redirect_to programme_path(@programme)
  #   else
  #     render "programme/show", status: :unprocessable_entity
  #   end
  # end

  # def update
  #   @pathway = Pathway.find(params[:id])
  #   @pathway.save!
  #   @programme = Programme.find(params[:programme_id])
  #   redirect_to programme_path(@programme)
  # end

  # private

  # def pathway_params
  #   params.require(:pathway).permit(:programme_id)
  # end

  # def set_programme
  #   @programme = Programme.find(params[:programme_id])
  # end
end
