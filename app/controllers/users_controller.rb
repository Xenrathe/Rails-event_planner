class UsersController < ApplicationController
  before_action :authenticate_user! 

  def show
    @user = User.find(params[:id])
    @owned_adventures = @user.adventures
    @attended_adventures = @user.characters.flat_map { |character| character.attended_adventures.includes(:adventure) }
    @characters = @user.characters.sorted_by_level
    @active_character = @user.active_character
  end
end
