class PathwaysController < ApplicationController
  # before_action :set_programme, except: :update
  # before_action :authenticate_user!

  def index
    @user = current_user
    @pathways = @user.pathways.order(id: :asc)
  end

  # def update
  #   @pathway = Pathway.find(update_pathways_id[:id])
  #   @pathway.update!(shortlist_pathway_params)
  # end

  # def new
  #   @pathways = Pathway.new
  # end

  def create
    @programme = Programme.find(params[:programme_id])
    @career = Career.find(params[:pathway][:career_id])

    @pathway = Pathway.new
    @pathway.user = current_user
    @pathway.programme = @programme

    respond_to do |format|
      if @pathway.save
        format.text do
          render partial: 'pathways/unshortlist', formats: :html, locals: { pathway: @pathway, career: @career }
        end
      else
        format.text do
          render partial: 'pathways/form', formats: :html, locals: { program: @programme, career_id: @career.id }
        end
      end
    end
  end

  def destroy
    @pathway = Pathway.find(params[:id])
    @career = Career.find(params[:career])
    @pathway.destroy
    redirect_to career_programmes_path(@career)
  end

  def update
    @pathway = Pathway.find(update_pathways_id[:id])
    @pathway.update!(primary_pathway_params)
    redirect_to pathways_path
  end

  private

  def update_pathways_id
    params.permit(:id)
  end

  def shortlist_pathway_params
    params.require(:pathway).permit(:shortlisted)
  end

  def primary_pathway_params
    params.require(:pathway).permit(:primary)
  end

  def update_pathways_id
    params.permit(:id)
  end

  # def set_programme
  #   @programme = Programme.find(params[:programme_id])
  # end
end
