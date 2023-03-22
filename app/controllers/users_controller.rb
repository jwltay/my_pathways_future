class UsersController < ApplicationController
  # def index
  #   @users = User.all
  # end

  # def show
  #   @user = User.find(params[:id])
  # end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update!(user_params.except(:subject_ids, :soft_skill_ids))
    user_params[:subject_ids].compact_blank.each { |id| @user.subjects << Subject.find(id) }
    user_params[:soft_skill_ids].compact_blank.each { |id| @user.soft_skills << SoftSkill.find(id) }
    if @user.save!
      redirect_to careers_path
      # create pathways
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :occupation,
      subject_ids: [],
      soft_skill_ids: []
    )
  end
end
