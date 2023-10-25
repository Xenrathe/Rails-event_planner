class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = User.find(params[:id])
    @owned_adventures = @user.adventures
    @attended_adventures = @user.characters.flat_map { |character| character.attended_adventures.includes(:adventure) }
    @characters = @user.characters.sorted_by_level
    @active_character = @user.active_character
  end

  def update
    @user = User.find(params[:id])
    if current_user && current_user.id == @user.id && @user.update(user_params)
      redirect_to @user, notice: "User bio updated successfully."
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end

end
