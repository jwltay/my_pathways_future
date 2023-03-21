class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to edit_user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :current_profession, :occupation)
  end
end
