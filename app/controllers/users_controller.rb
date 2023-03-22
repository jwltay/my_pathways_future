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
    @user.update!(user_update_params)
    subject_ids.each { |id| @user.user_subjects.build(subject_id: id) }
    soft_skill_ids.each { |id| @user.user_soft_skills.build(soft_skill_id: id) }
    @user.generate_pathways
    if @user.save!
      redirect_to careers_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # safe params for updating user's first name, last name, and occupation
  def user_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :occupation
    )
  end

  # safe params
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :occupation,
      subject_ids: [],
      soft_skill_ids: []
    )
  end

  # extracts array of subject_ids from safe params and removes empty string
  def subject_ids
    user_params[:subject_ids].compact_blank
  end

  # extracts array of soft_skill_ids from safe params and removes empty string
  def soft_skill_ids
    user_params[:soft_skill_ids].compact_blank
  end
end
